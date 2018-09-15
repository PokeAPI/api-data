# PokeAPI Data 

This repository contains:

 - [data/api](data/api): a static copy of the JSON data generated with the above script
 - [data/schema](data/schema): a static copy of the PokeAPI schema generated from the above data
 - [updater](updater): a bot that runs in docker and can update the data stored in this repo

You can manually update the data if necessary. See [the updater bot](updater).
You can run the bot in docker, or read and adapt its update script yourself. 
