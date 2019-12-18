#!/usr/bin/env pwsh

param (
    [string]$KeyName = "id_rsa",
    [Parameter(Mandatory=$true)][string]$CommitterEmail
)

docker run -itd --rm --name pokeapi-api-data-updater --privileged -e COMMIT_EMAIL=${CommitterEmail} pokeapi-updater bash

docker exec pokeapi-api-data-updater mkdir -p /root/.ssh/

docker cp ${HOME}/.ssh/${KeyName} pokeapi-api-data-updater:/root/.ssh/id_rsa
docker cp ${HOME}/.ssh/${KeyName}.pub pokeapi-api-data-updater:/root/.ssh/id_rsa.pub
docker cp ${HOME}/.ssh/known_hosts pokeapi-api-data-updater:/root/.ssh/known_hosts

docker exec pokeapi-api-data-updater chmod 600 /root/.ssh/id_rsa
docker exec pokeapi-api-data-updater chmod 644 /root/.ssh/id_rsa.pub
docker exec pokeapi-api-data-updater chmod 644 /root/.ssh/known_hosts

docker exec pokeapi-api-data-updater bash cmd.bash

docker stop pokeapi-api-data-updater
