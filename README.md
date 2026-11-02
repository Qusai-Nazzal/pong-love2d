# Pong — LÖVE 2D

**Student:** Qusai Nazzal  
**Class / Section:** AI In Gaming section 1

A simple two-player Pong game made with Lua and LÖVE 2D. Each player controls a paddle on their side of the screen and tries to send the ball past the opponent. The game includes keyboard controls, wall and paddle collisions, a score display, and progressive ball speed: each paddle hit makes the ball 5% faster, up to a playable maximum. After a point, the ball returns to the center at its starting speed.

## Requirements

Install [LÖVE 2D](https://love2d.org/) for your operating system. This project uses only Lua and the built-in LÖVE API; it has no external libraries.

## Run the game

Open a terminal in the project folder and run:

```sh
love .
```

On Windows, if `love` is not on your PATH, use the full path to `love.exe` or add its installation folder to PATH.

## Controls

- **Left player:** W (up), S (down)
- **Right player:** Up Arrow (up), Down Arrow (down)
- **Escape:** Quit

## Progressive ball speed

Every time the ball hits a paddle, its velocity is multiplied by 1.05, increasing its speed by about 5%. The speed is capped at 600 pixels per second. When a player scores, the ball resets to its original speed. Keeping this feature in one small function makes the change easy to follow.

## Screenshot

[`screenshots/pong.png`](screenshots/pong.png). The folder is included

## Demo video

[`demo/pong-demo.mp4`](demo/pong-demo.mp4). The folder is included

