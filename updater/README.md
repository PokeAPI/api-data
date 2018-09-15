# Updater Bot

## Usage

First, make sure you can read/write the target repository over SSH.
Launch the bot with a volume containing the SSH keys to `/root/.ssh` and an environment variable for email address.
Since this container runs Docker within itself, it needs to run in privileged mode.

```
docker run --privileged -v ~/.ssh:/root/.ssh -e COMMIT_EMAIL=example@example.com sargunv/pokeapi-ditto:updater
```

**Note:** Due to lack of support for file permissions, this does not work on Docker for Windows.

## Environment Variables

### Required

 - `COMMIT_EMAIL`

### Optional

See [the Dockerfile](updater/Dockerfile) for the defaults.

 - `COMMIT_NAME`
 - `COMMIT_MESSAGE`
 - `BRANCH_NAME`
 - `REPO_POKEAPI`
 - `REPO_DITTO`
