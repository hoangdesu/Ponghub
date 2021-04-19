push = require '/lib/push'
require 'Paddle'
require 'Ball'

-- Constants
desktopWidth, desktopHeight = love.window.getDesktopDimensions()
WINDOW_WIDTH = desktopWidth / 1.2
WINDOW_HEIGHT = desktopHeight / 1.2
VIRTUAL_WIDTH = 480 
VIRTUAL_HEIGHT = 300

PADDLE_SPEED = 500
PADDLE_WIDTH = 40
PADDLE_HEIGHT = 4

BALL_WIDTH = 7
BALL_DX_RANGE = 200
BALL_DY_RANGE = 150
BALL_ACCELERATION = 1.05


function love.load()
    love.window.setTitle('PongHub')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time()) -- random initialize
    math.random(); math.random(); math.random() -- warming up
    titleFont = love.graphics.newFont('/fonts/noodle.ttf', 20)
    scoreFont = love.graphics.newFont('/fonts/noodle.ttf', 25)
    fpsFont = love.graphics.newFont('/fonts/arcade.ttf', 12)

    push:setupScreen(
        VIRTUAL_WIDTH, 
        VIRTUAL_HEIGHT, 
        WINDOW_WIDTH, 
        WINDOW_HEIGHT, {
            fullscreen = false,
            resizable = false,
            vsync = false
        })

    gameState = 'start'

    player1 = Paddle('top', PADDLE_WIDTH, PADDLE_HEIGHT)
    player2 = Paddle('bot', PADDLE_WIDTH, PADDLE_HEIGHT)

    ball = Ball(BALL_WIDTH)

end

-- Update
function love.update(dt)
    -- Paddle control
    if love.keyboard.isDown('a') then
        player1.dx = -PADDLE_SPEED
    elseif love.keyboard.isDown('d') then
        player1.dx = PADDLE_SPEED
    else
        player1.dx = 0
    end
    
    if love.keyboard.isDown('left') then
        player2.dx = -PADDLE_SPEED
    elseif love.keyboard.isDown('right') then
        player2.dx = PADDLE_SPEED
    else
        player2.dx = 0
    end

    
    player1:update(dt)
    player2:update(dt)

    
    if gameState == 'play' then
        if ball:collides(player1) or ball:collides(player2) then
            ball.dy = -ball.dy * BALL_ACCELERATION
            ball.dx = math.random(-BALL_DX_RANGE, BALL_DX_RANGE)
        end
        ball:bounce()
        ball:update(dt)
    end
end

-- Key events
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'space' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'
            ball:reset(dt)
            player1:reset()
            player2:reset()
        end
    end
end


-- Draw
function love.draw()
    push:start()
    -- Background
    r, g, b = 100, 70, 70
    love.graphics.clear(r/255, g/255, b/255, 1)

    -- Title
    displayTitle()

    -- FPS
    displayFPS()

    -- Score
    player1:renderScore('top')
    player2:renderScore('bot')

    -- Paddles
    player1:renderPaddle()
    player2:renderPaddle()

    -- Ball
    ball:render()

    push:finish()
end

function setColor(color)
    if color == 'white' then
        r, g, b = 255, 255, 255
    elseif color == 'black' then
        r, g, b = 1, 1, 1
    elseif color == 'red' then
        r, g, b = 161, 57, 10
    end
    love.graphics.setColor(r/255, g/255, b/255, 1)
end

function setRGB(r, g, b)
    love.graphics.setColor(r/255, g/255, b/255, 1)
end

function displayTitle()
    setRGB(230, 255, 224)
    love.graphics.setFont(titleFont)
    love.graphics.printf(
    'PongHub', 
    0, 
    15, 
    VIRTUAL_WIDTH, 
    'center')
end

function displayFPS()
    setRGB(119, 250, 90)
    love.graphics.setFont(fpsFont)
    love.graphics.printf(
    "FPS: "..tostring(love.timer.getFPS()), 
    3, 
    3, 
    VIRTUAL_WIDTH, 
    'left')
end
