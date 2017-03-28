# HI THERE

This is my 

# Bitcoin Transaction Counter

[Check out the live version of this project](http://bitcoin-transaction-counter.surge.sh/).

To get this going on your computer, download or clone the repo, and then type into your console..
```
> npm install
> elm package install --yes
> gulp

then open up http://localhost:2982
```


This repo is organized as ..
```
development/          -- Your development app
  index.html
source/               -- Source files
  app.js              -- Loads your elm file
  Main.elm
  *.elm
  Main/               -- Primary Elm Files
    View.elm          -- Top level view file
    Update.elm        -- Top level update function
    WebSocket.elm     -- Handles websockets
    *.elm 
  Styles/
    Main.styl         -- Main style file
    *.styl            -- Many other style files that get concatentated together
  Types/              -- Primary types, and basic functions re those types
    Model.elm        
    Message.elm
    *.elm
  Util/
    *.elm             -- Gritty computation heavy processes
  View/
    *.elm             -- Basic view components
gulpFile.js
server.js


## Elm Format

There is an [Elm-Format](https://github.com/avh4/elm-format) task in this gulp file. Its not on by default, but you can switch to it by uncommenting a little code. 