# PokéAPI data <a href="https://pokeapi.co/api/v2/pokemon/uxie"><img src='https://veekun.com/dex/media/pokemon/global-link/480.png' height=50px/></a>

[![CircleCI](https://circleci.com/gh/PokeAPI/api-data.svg?style=shield)](https://circleci.com/gh/PokeAPI/api-data)

This repository contains:

- [data/api](data/api): a static copy of the JSON data produced by [PokeAPI](https://github.com/PokeAPI/pokeapi)
- [data/schema](data/schema): a static copy of the PokeAPI schema generated from the above data
- [updater](updater): a [Ditto][1] based bot that runs in docker and updates the data stored in this repo

## Usage

If you'd like to use the JSON for your own purposes, you can apply your own base URL using [Ditto][1]:

```sh
ditto transform --base-url='https://pokeapi.co'
```

## Updater bot

You can manually update the data if necessary. See [the updater bot](updater).
You can run the bot in docker, or read and adapt its update script yourself.

[1]: https://github.com/pokeapi/ditto
