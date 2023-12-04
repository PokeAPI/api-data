#!/usr/bin/env bash

[ -z "${REPO_POKEAPI}" ] && { echo "Need to set REPO_POKEAPI"; exit 1; }
[ -z "${REPO_DATA}" ] && { echo "Need to set REPO_DATA"; exit 1; }
[ -z "${BRANCH_NAME}" ] && { echo "Need to set BRANCH_NAME"; exit 1; }
[ -z "${REPO_POKEAPI_CHECKOUT_OBJECT:=master}" ] && { echo "REPO_POKEAPI_CHECKOUT_OBJECT not set, defaulting to \`master\`"; }
[ -z "${REPO_APIDATA_CHECKOUT_OBJECT:=master}" ] && { echo "REPO_APIDATA_CHECKOUT_OBJECT not set, defaulting to \`master\`"; }
[ -z "${TEST:=true}" ]
declare -r COMMIT_AND_PUSH="${COMMIT_AND_PUSH:-false}"

set -e
set -o pipefail
set -x

dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 &> /dev/null &

git clone "$REPO_POKEAPI" pokeapi
git clone --depth=1 "$REPO_DATA" api-data

# set up the pokeapi side
cd pokeapi
git checkout "$REPO_POKEAPI_CHECKOUT_OBJECT"
git submodule init
git submodule update --remote

docker compose -f docker-compose.yml -f docker-compose-dev.yml up -d

docker compose exec -T app python manage.py migrate --settings=config.docker-compose
docker compose exec -T app sh -c 'echo "from data.v2.build import build_all; build_all()" | python manage.py shell --settings=config.docker-compose'

# set up the data side
cd ../api-data
git checkout "$REPO_APIDATA_CHECKOUT_OBJECT"
git branch -D "$BRANCH_NAME" || true
git branch "$BRANCH_NAME"
git checkout "$BRANCH_NAME"

pip install -r requirements.txt
rm -r ./data
ditto clone --src-url http://localhost/ --dest-dir ./data
# (╯°□°)╯ *always* assume magikarp failed and grab it again #clowntown
ditto clone --src-url http://localhost/ --dest-dir ./data --select pokemon/129
ditto analyze --data-dir ./data

# commit and push
if [ "$COMMIT_AND_PUSH" = 'true' ]; then
    [ -z "${COMMIT_NAME}" ] && { echo "Need to set COMMIT_NAME"; exit 1; }
    [ -z "${COMMIT_EMAIL}" ] && { echo "Need to set COMMIT_EMAIL"; exit 1; }
    [ -z "${COMMIT_MESSAGE}" ] && { echo "Need to set COMMIT_MESSAGE"; exit 1; }
    git add data
    git config user.name "$COMMIT_NAME"
    git config user.email "$COMMIT_EMAIL"
    if ! git commit -m "$COMMIT_MESSAGE"; then
        echo "The generated data doesn't bring any updates"
        exit 2
    fi
    git push -fu origin "$BRANCH_NAME"
fi
