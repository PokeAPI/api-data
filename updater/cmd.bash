#!/usr/bin/env bash

[ -z "${COMMIT_NAME}" ] && { echo "Need to set COMMIT_NAME"; exit 1; }
[ -z "${COMMIT_EMAIL}" ] && { echo "Need to set COMMIT_EMAIL"; exit 1; }
[ -z "${COMMIT_MESSAGE}" ] && { echo "Need to set COMMIT_MESSAGE"; exit 1; }
[ -z "${REPO_POKEAPI}" ] && { echo "Need to set REPO_POKEAPI"; exit 1; }
[ -z "${REPO_DATA}" ] && { echo "Need to set REPO_DATA"; exit 1; }
[ -z "${BRANCH_NAME}" ] && { echo "Need to set BRANCH_NAME"; exit 1; }

set -e
set -o pipefail
set -x

export COMPOSE_INTERACTIVE_NO_CLI=1

dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 &> /dev/null &

git clone --depth=1 "$REPO_POKEAPI" pokeapi
git clone "$REPO_DATA" api-data

# set up the pokeapi side
cd pokeapi

docker volume create --name=redis_data
docker volume create --name=pg_data
docker-compose up -d

docker-compose exec -T app python manage.py migrate --settings=config.docker-compose
docker-compose exec -T app sh -c 'echo "from data.v2.build import build_all; build_all()" | python manage.py shell --settings=config.docker-compose'

# set up the data side
cd ../api-data
# git branch -D "$BRANCH_NAME" || true
# git branch "$BRANCH_NAME"
# git checkout "$BRANCH_NAME"
git checkout "$BRANCH_NAME"

pip install -r requirements.txt
rm -r ./data
ditto clone --src-url http://localhost/ --dest-dir ./data
# (╯°□°)╯ *always* assume magikarp failed and grab it again #clowntown
ditto clone --src-url http://localhost/ --dest-dir ./data --select pokemon/129
ditto analyze --data-dir ./data

# commit and push
git add data
git config user.name "$COMMIT_NAME"
git config user.email "$COMMIT_EMAIL"
git commit -m "$COMMIT_MESSAGE"
git push -fu origin "$BRANCH_NAME"
