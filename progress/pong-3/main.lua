push = require 'push'
math.randomseed(os.time()) -- random initialize
math.random(); math.random(); math.random() -- warming up

-- Constants
WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 420, 220

PADDLE_WIDTH = 50
PADDLE_HEIGHT = 8

BALL_WIDTH, BALL_HEIGHT = 7, 7

PADDLE_SPEED = 500


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    titleFont = love.graphics.newFont('noodle.ttf', 20)
    scoreFont = love.graphics.newFont('noodle.ttf', 25)

    push:setupScreen(VIRTUAL_WIDTH, 
        VIRTUAL_HEIGHT, 
        WINDOW_WIDTH, 
        WINDOW_HEIGHT, {
            fullscreen = false,
            resizable = true,
            vsync = true
        })

    player1X = math.random(VIRTUAL_WIDTH - PADDLE_WIDTH) 
    player2X = math.random(VIRTUAL_WIDTH - PADDLE_WIDTH)

    player1Score = 10
    player2Score = 0
end

-- Update
function love.update(dt)
    if love.keyboard.isDown('q') then
        if player1X > 2 then
            player1X = player1X - PADDLE_SPEED * dt
        end
    elseif love.keyboard.isDown('e') then
        if player1X < VIRTUAL_WIDTH - PADDLE_WIDTH then
            player1X = player1X + PADDLE_SPEED * dt
        end
    end

    if love.keyboard.isDown('left') then
        if player2X > 2 then
            player2X = player2X - PADDLE_SPEED * dt
        end
    elseif love.keyboard.isDown('right') then
        if player2X < VIRTUAL_WIDTH - PADDLE_WIDTH then
            player2X = player2X + PADDLE_SPEED * dt
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
    love.graphics.setFont(titleFont)
    love.graphics.printf(
    'Pinh Pông!', 
    0, 
    10, 
    VIRTUAL_WIDTH, 
    'center')

    -- Player 1 Score
    love.graphics.setFont(scoreFont)
    love.graphics.printf(
    player1Score, 
    30, 
    10, 
    VIRTUAL_WIDTH, 
    'left')

    -- Player 2 Score
    love.graphics.setFont(scoreFont)
    love.graphics.printf(
    player2Score, 
    -30, 
    10, 
    VIRTUAL_WIDTH, 
    'right')

    -- Top paddle (Player 1)
    love.graphics.rectangle(
        'fill',
        player1X,
        VIRTUAL_HEIGHT/5,
        PADDLE_WIDTH,
        PADDLE_HEIGHT
    )
    -- Bottom paddle (Player 2)
    love.graphics.rectangle(
        'fill',
        player2X,
        VIRTUAL_HEIGHT - 20,
        PADDLE_WIDTH,
        PADDLE_HEIGHT
    )
    -- Ball
    r, g, b = 203, 60, 30
    love.graphics.setColor(r/255, g/255, b/255, 1)
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
