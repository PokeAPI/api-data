FROM docker:18.09.3-dind

RUN apk update
RUN apk add curl python3 git bash dos2unix openssh build-base python3-dev

RUN ln -sf $(ls /usr/bin/easy_install*) /usr/bin/easy_install
RUN easy_install pip
COPY --from=docker/compose:1.25.0-alpine /usr/local/bin/docker-compose /usr/local/bin/

RUN mkdir /updater
WORKDIR /updater
COPY . /updater/
RUN dos2unix cmd.bash

ENV COMMIT_NAME 'Updater Bot'
ENV COMMIT_EMAIL ''
ENV COMMIT_MESSAGE '[Updater Bot] Regenerate data'
ENV BRANCH_NAME 'updater-bot'
ENV REPO_POKEAPI 'git@github.com:PokeAPI/pokeapi'
ENV REPO_DATA 'git@github.com:PokeAPI/api-data'

CMD bash cmd.bash
