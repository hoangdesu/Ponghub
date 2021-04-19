-- Import push library
push = require 'push'

WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 420, 220

-- print(WINDOW_WIDTH, WINDOW_HEIGHT)

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    noodle = love.graphics.newFont('noodle.ttf', 20)
    love.graphics.setFont(noodle)

    push:setupScreen(VIRTUAL_WIDTH, 
        VIRTUAL_HEIGHT, 
        WINDOW_WIDTH, 
        WINDOW_HEIGHT, {
            fullscreen = false,
            resizable = true,
            vsync = true
        })
end

-- Draw
function love.draw()
    push:start()
    -- Background
    r, g, b = 100, 70, 70
    love.graphics.clear(r/255, g/255, b/255, 1)
    love.graphics.printf(
    'Pinh Pông!', 
    0, 
    15, 
    VIRTUAL_WIDTH, 
    'center')

    PADDLE_WIDTH = 50
    PADDLE_HEIGHT = 8
    -- Top paddle
    love.graphics.rectangle(
        'fill',
        VIRTUAL_WIDTH/2 - PADDLE_WIDTH/2,
        VIRTUAL_HEIGHT/5,
        PADDLE_WIDTH,
        PADDLE_HEIGHT
    )
    -- Bottom paddle
    love.graphics.rectangle(
        'fill',
        VIRTUAL_WIDTH/2 - PADDLE_WIDTH/2,
        VIRTUAL_HEIGHT - 20,
        PADDLE_WIDTH,
        PADDLE_HEIGHT
    )

    BALL_WIDTH, BALL_HEIGHT = 7, 7
    -- Ball
    love.graphics.rectangle(
        'fill',
        VIRTUAL_WIDTH/2 - BALL_WIDTH/2,
        VIRTUAL_HEIGHT/2,
        BALL_WIDTH,
        BALL_HEIGHT
    )

    push:finish()
end

-- Key events
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
