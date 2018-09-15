# PokeAPI Data

[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/pokeapi/api-data)

This repository contains:

 - [data/api](data/api): a static copy of the JSON data generated with the above script
 - [data/schema](data/schema): a static copy of the PokeAPI schema generated from the above data
 - [updater](updater): a [Ditto][1] based bot that runs in docker and can update the data stored in this repo
 - Deployment configs to deploy an instance of the API to [Netlify][2]

If you'd like to use the JSON for your own purposes, you can apply your own base URL using [Ditto][1]:

```
ditto transform --base-url='https://pokeapi.co'
```

You can manually update the data if necessary. See [the updater bot](updater).
You can run the bot in docker, or read and adapt its update script yourself.


[1]: https://github.com/pokeapi/ditto
[2]: https://www.netlify.com/
