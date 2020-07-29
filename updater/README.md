# Updater Bot <a href="https://pokeapi.co/api/v2/pokemon/porygon"><img src='https://veekun.com/dex/media/pokemon/global-link/137.png' height=50px/></a>

[![Docker Repository on Quay](https://quay.io/repository/pokeapi/updater/status "Docker Repository on Quay")](https://quay.io/repository/pokeapi/updater)

## Usage

First, make sure you can read/write the target repository over SSH.
Launch the bot with a volume containing the SSH keys to `/root/.ssh` and an environment variable for email address.
Since this container runs [Docker](https://hub.docker.com/_/docker) within itself, it needs to run in privileged mode.

```sh
docker run --privileged -v ~/.ssh:/root/.ssh -e COMMIT_EMAIL=example@example.com quay.io/pokeapi/updater
```

Check the log for failed clones, sometimes <img src="https://veekun.com/dex/media/pokemon/global-link/129.png" alt="Magikarp" height="20"/>  times out.

## Environment Variables

### Required

- `COMMIT_EMAIL`

### Optional

See [the Dockerfile](updater/Dockerfile) for the defaults.

- `COMMIT_NAME`
- `COMMIT_MESSAGE`
- `BRANCH_NAME`
- `REPO_POKEAPI`
- `REPO_DATA`

## Build Docker image

```sh
docker build -t pokeapi-updater .
```

## Run on Windows

Your public/private keys with `KeyName` name will be shared with the pokeapi-updater container. Be sure those keys are the ones with write access on https://github.com/PokeAPI/pokeapi

```pwsh
pwsh Run-Updater.ps1 -KeyName id_rsa -CommitterEmail example@example.com
```
