push = require 'push'
math.randomseed(os.time()) -- random initialize
math.random(); math.random(); math.random() -- warming up

-- Constants
WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()
WINDOW_WIDTH = WINDOW_WIDTH / 1.2
WINDOW_HEIGHT = WINDOW_HEIGHT / 1.2
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 480, 300

PADDLE_WIDTH = 50
PADDLE_HEIGHT = 8

BALL_WIDTH, BALL_HEIGHT = 7, 7

PADDLE_SPEED = 600


function love.load()
    love.window.setTitle('Pinh Pông')
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

    gameState = 'start'

    player1X = math.random(VIRTUAL_WIDTH - PADDLE_WIDTH) 
    player2X = math.random(VIRTUAL_WIDTH - PADDLE_WIDTH)

    player1Score = 10
    player2Score = 5

    ballX = VIRTUAL_WIDTH / 2 - BALL_WIDTH/2
    ballY = VIRTUAL_HEIGHT / 2

    ballDX = math.random(-50, 50) * 1.5
    ballDY = math.random(2) == 0 and 100 or -100 -- tenary

end

-- Update
function love.update(dt)
    
    if love.keyboard.isDown('a') then
        player1X = math.max(0, player1X - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('d') then
        player1X = math.min(VIRTUAL_WIDTH - PADDLE_WIDTH, player1X + PADDLE_SPEED * dt)
    end

    if love.keyboard.isDown('left') then
        player2X = math.max(0, player2X - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('right') then
        player2X = math.min(VIRTUAL_WIDTH - PADDLE_WIDTH, player2X + PADDLE_SPEED * dt)
    end

    -- Testing score
    -- if love.keyboard.isDown('return') then
    --     player1Score = player1Score + 1
    -- elseif love.keyboard.isDown('down') then
    --     player1Score = player1Score - 1
    -- end

    ballX = ballX + ballDX * dt
    ballY = ballY + ballDY * dt
    -- player1X = ballX - PADDLE_WIDTH/2

    
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
        VIRTUAL_HEIGHT - 30,
        PADDLE_WIDTH,
        PADDLE_HEIGHT
    )
    -- Ball
    r, g, b = 203, 60, 30
    love.graphics.setColor(r/255, g/255, b/255, 1)
    love.graphics.rectangle(
        'fill',
        ballX,
        ballY,
        BALL_WIDTH,
        BALL_HEIGHT
    )

    push:finish()
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

            ballX = VIRTUAL_WIDTH / 2 - BALL_WIDTH/2
            ballY = VIRTUAL_HEIGHT / 2

            ballDX = math.random(-50, 50) * 1.5
            ballDY = math.random(2) == 0 and 100 or -100 -- tenary
            -- ballDX = 0
            -- ballDY = 0
        end
    end
end

