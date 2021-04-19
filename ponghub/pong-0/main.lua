-- This is a comment
-- Setting up resolution constants

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 500
VIRTUAL_HEIGHT = 300

-- Require push library for drawing virtual resolutions
local push = require 'push'

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false;
        resizable = true;
        vsync = true;
    })
    love.graphics.setDefaultFilter('linear', 'linear')
end

function love.draw()

    love.graphics.printf(
        'Ping Pong!',
        0,
        WINDOW_HEIGHT / 2 - 6, 
        WINDOW_WIDTH,
        'center')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
