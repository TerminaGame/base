# Termina (Base + CLI)

![Screenshot](screenshot.png)

Termina is a fun single-user, level-based user dungeon game for macOS and Linux.

[![Build Status](https://travis-ci.com/TerminaGame/base.svg?branch=master)](https://travis-ci.com/TerminaGame/base)
![Swift Version](https://img.shields.io/badge/swift-4.0-orange.svg)

This repository provides the base source code for the game as well as the project files for building the command line version via Xcode.

## Features
- [x] Infinite room generation
- [x] Experience and level system
- [x] Attack and heal system
- [x] Persistent data or load games
- [x] Inventory system

## Downloads
Currently, there are no releases of Termina ready for the public. However, feel free to build the source code to try it yourself!

## GUIs
If you're looking for GUI versions, we recommend looking at the following projects:
- [TerminaGame/mac](https://github.com/TerminaGame/mac): official SpriteKit version of Termina for macOS


## About Logging Features
Termina does log information about your current session for your convenience. However, this data is _not_ stored anywhere and will only be saved when the user asks for this log to be exported to a text file (`termlog.txt`).

**Libraries used**:
- [Files](https://github.com/JohnSundell/Files)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

**Termina is licensed under the Apache License. Libraires used in Termina are under their respective licenses.**
