# [Ponghub](https://github.com/hoangdesu/Ponghub) [![SFW](https://img.shields.io/badge/SFW-safe%20for%20work-orange)](https://github.com/facebook/react/blob/master/LICENSE)
###### *(an absolutely SFW game, suitable for your children!)*

### Table of Contents
* [What?](#what)  
* [Download](#download) 
* [Installation](#installation) 
* [Controls](#controls)
* [Credits](#credits)
  
<a name="what"></a>
## What?
This is my attempt of [CS50 Game Development's Pong tutorial](https://github.com/cs50/gd50/tree/master/pong). In my version, the game view is rotate to vertical. And don't even ask me about the title 👀

![Gameplay](./Screenshots/gameplay.gif "Gameplay")

<a name="download"></a>
## Download

<a name="installation"></a>
## Installation
If you want to compile the game yourself, you'd need Lua and LÖVE2D framework.
If you are on a Mac, you can install using Brew:
1. Install Lua:
```
brew install lua
```

2. Install LÖVE2D:
```
brew install --cask love
```

3. Add love alias to your PATH:
```
alias love="/Applications/love.app/Contents/MacOS/love"
```

4. Clone the project:
```
git clone https://github.com/hoangdesu/Ponghub.git
```

5. Go to the project and run the game:
```
cd Ponghub/src
love .
```

<a name="controls"></a>
## Controls
The blinking player is the server.
##### Player 1 (top dude):
* Move: A, D
* Serve: S
##### Player 2 (bottom dude):
* Move: ⬅️ ➡️ (left/right arrow keys)
* Serve: ⬆️ (up arrow keys)

**ESC**: go back
**M**: mute sound


<a name="screenshots"></a>
### Screenshots
<p align="center">Welcome screen</p>

![welcome](./Screenshots/welcome.png "Welcome")

<p align="center">Victory screen</p>

![victory](./Screenshots/victory.png "Victory")

<a name="credits"></a>
### Credits





