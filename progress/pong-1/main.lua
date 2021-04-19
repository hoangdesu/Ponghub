-- Import push library

push = require 'push'

WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 1080, 720

-- print(WINDOW_WIDTH, WINDOW_HEIGHT)
function love.load()
    push:setupScreen(VIRTUAL_WIDTH, 
        VIRTUAL_HEIGHT, 
        WINDOW_WIDTH, 
        WINDOW_HEIGHT, {
            fullscreen = false
        })
    love.graphics.setDefaultFilter('nearest', 'nearest')
end

function love.draw()
    push:start()
    love.graphics.printf('Ping Pong!', 
    0, 
    VIRTUAL_HEIGHT/2, 
    VIRTUAL_WIDTH, 
    'center')
    push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
