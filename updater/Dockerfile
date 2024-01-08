FROM docker:24.0.7-dind-alpine3.18

RUN apk update
RUN apk add curl python3 git bash build-base python3-dev py3-pip

RUN mkdir /updater
WORKDIR /updater
COPY . /updater/

ENV COMMIT_NAME 'Updater Bot'
ENV COMMIT_EMAIL ''
ENV COMMIT_MESSAGE '[Updater Bot] Regenerate data'
ENV BRANCH_NAME 'updater-bot'
ENV REPO_POKEAPI 'https://github.com/PokeAPI/api-data.git'
ENV REPO_DATA 'https://github.com/PokeAPI/api-data.git'

CMD bash cmd.bash
