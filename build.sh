#!/bin/bash

set -e
set -o pipefail
set -x

yarn run netlify-lambda build functions
ditto transform --base-url='https://pokeapi-prod.netlify.com/' --dest-dir='_dist'
