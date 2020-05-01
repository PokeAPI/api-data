#!/bin/sh
# Runs in CircleCI
# Replaces all the http://localhost links of api-data to match the corresponding deployment location.

if [ "${CIRCLE_BRANCH}" = 'master' ]; then # https://stackoverflow.com/a/2013589/3482533
    ~/.local/bin/ditto transform --base-url='https://pokeapi.co' --src-dir=data --dest-dir=_gen
elif [ "${CIRCLE_BRANCH}" = 'staging' ]; then
    ~/.local/bin/ditto transform --base-url='https://pokeapi-test-b6137.firebaseapp.com' --src-dir=data --dest-dir=_gen
fi
