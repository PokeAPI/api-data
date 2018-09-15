#!/bin/bash

set -e
set -o pipefail
set -x

yarn run netlify-lambda build functions
sed -i "s/\$BASE_URL/$BASE_URL/" _functions/*.js
ditto transform --base-url="$BASE_URL" --dest-dir='_dist'
