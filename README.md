# PokeAPI Data 

This repository contains:

 - [data/api](data/api): a static copy of the JSON data generated with the above script
 - [data/schema](data/schema): a static copy of the PokeAPI schema generated from the above data
 - [updater](updater): a [Ditto](https://github.com/pokeapi/ditto) based bot that runs in docker
   and can update the data stored in this repo

If you'd like to use the JSON, you can apply your own base URL using [Ditto](https://github.com/pokeapi/ditto):

```
ditto transform --base-url='https://pokeapi.co'
```

You can manually update the data if necessary. See [the updater bot](updater).
You can run the bot in docker, or read and adapt its update script yourself. 
