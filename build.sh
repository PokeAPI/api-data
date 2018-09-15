#!/bin/bash

set -e
set -o pipefail
set -x

yarn install
yarn run netlify-lambda build functions

poetry install --no-dev
poetry run ditto transform --base-url='https://pokeapi-prod.netlify.com/' --dest-dir='_dist'
