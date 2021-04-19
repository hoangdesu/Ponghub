push = require '/lib/push'
require 'Paddle'
require 'Ball'

-- Constants
desktopWidth, desktopHeight = love.window.getDesktopDimensions()
WINDOW_WIDTH = desktopWidth / 1.2
WINDOW_HEIGHT = desktopHeight / 1.2
VIRTUAL_WIDTH = 480 
VIRTUAL_HEIGHT = 300

PADDLE_SPEED = 400
PADDLE_WIDTH = 20
PADDLE_HEIGHT = 4

BALL_WIDTH = 6
BALL_DX_RANGE = 250
BALL_DY_RANGE = 250
BALL_ACCELERATION = 1.05

WINNING_SCORE = 10


function love.load()
    love.window.setTitle('PongHub')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time()) -- random initialize
    math.random(); math.random(); math.random() -- warming up
    titleFont = love.graphics.newFont('/fonts/noodle.ttf', 22)
    scoreFont = love.graphics.newFont('/fonts/noodle.ttf', 25)
    fpsFont = love.graphics.newFont('/fonts/arcade.ttf', 12)

    sfx = {
        ['bgm'] = love.audio.newSource('sfx/bgm.mp3', 'static'),
        ['select'] = love.audio.newSource('sfx/select.wav', 'static'),
        ['score'] = love.audio.newSource('sfx/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sfx/wall.wav', 'static'),
        ['serve'] = love.audio.newSource('sfx/serve.wav', 'static'),
        ['paddle_hit'] = love.audio.newSource('sfx/paddle.wav', 'static'),
        ['escape'] = love.audio.newSource('sfx/escape.wav', 'static'),
        ['victory'] = love.audio.newSource('sfx/victory.mp3', 'static'),
    }
    
    love.audio.setVolume(0.5)

    joystick = love.joystick.getJoysticks()[1]
    stick = {}

    push:setupScreen(
        VIRTUAL_WIDTH, 
        VIRTUAL_HEIGHT, 
        WINDOW_WIDTH, 
        WINDOW_HEIGHT, {
            fullscreen = false,
            resizable = true,
            vsync = false
        })

    sfx['bgm']:setLooping(true)
    sfx['bgm']:setVolume(0.5)
    sfx['bgm']:play()

    gameState = 'start'
    servingPlayer = math.random(2)

    player1 = Paddle('top', PADDLE_WIDTH, PADDLE_HEIGHT)
    player2 = Paddle('bot', PADDLE_WIDTH, PADDLE_HEIGHT)

    ball = Ball(BALL_WIDTH)

end

function love.resize(w, h)
    push:resize(w, h)
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

 
    -- stick.x1, stick.y1, stick.x2, stick.y2, stick.click1, stick.click2 = joystick:getAxes() 

    -- if stick.x1 < - 0.1 or stick.x1 > 0.1 then
    --     player1.dx = PADDLE_SPEED * stick.x1
    -- end
    -- if stick.x2 < - 0.1 or stick.x2 > 0.1 then
    --     player2.dx = PADDLE_SPEED * stick.x2
    -- elseif joystick:isGamepadDown('a') or joystick:isGamepadDown('dpdown') then
    --     gameState = 'play'
    -- end

    player1:update(dt)
    player2:update(dt)

    if gameState == 'serve' then
        ball:reset(player1, player2)

        if servingPlayer == 1 then
            ball.dy = ball.dy
        elseif servingPlayer == 2 then
            ball.dy = -ball.dy
        end

    elseif gameState == 'play' then

        if ball:collides(player1) then
            sfx['paddle_hit']:play()
            ball.dy = -ball.dy * BALL_ACCELERATION
            ball.dx = math.random(-BALL_DX_RANGE, BALL_DX_RANGE)
        elseif ball:collides(player2) then
            sfx['paddle_hit']:play()
            ball.dy = -ball.dy * BALL_ACCELERATION
            ball.dx = math.random(-BALL_DX_RANGE, BALL_DX_RANGE)
        end

        if ball.y < 0 - ball.width then
            player2.score = player2.score + 1
            sfx['score']:play()
            servingPlayer = 1
            gameState = 'serve'
        elseif ball.y > VIRTUAL_HEIGHT then
            player1.score = player1.score + 1
            sfx['score']:play()
            servingPlayer = 2
            gameState = 'serve'
        end

        if player1.score == WINNING_SCORE then
            winner = 1
            gameState = 'victory'
            sfx['victory']:play()
        elseif player2.score == WINNING_SCORE then
            winner = 2
            gameState = 'victory'
            sfx['victory']:play()
        end

        ball:bounce()
        ball:update(dt)
    
    end
end

-- Key events
function love.keypressed(key)
    if key == 'm' then
        if love.audio.getVolume() > 0 then
            love.audio.setVolume(0)
        else 
            love.audio.setVolume(0.5)
        end
    end

    if gameState == 'start' then
        if key == 'escape' then
            sfx['escape']:play()
            love.event.quit()
        elseif key == 'return' then
            gameState = 'serve'
            sfx['select']:play()
        end
    elseif gameState == 'serve' then
        if key == 'escape' then
            sfx['escape']:play()
            gameState = 'start'
        end

        if servingPlayer == 1 then
            if key == 's' then
                gameState = 'play'
                sfx['serve']:play()
            end
        elseif servingPlayer == 2 then
            if key == 'up' then
                gameState = 'play'
                sfx['serve']:play()
            end
        end
    elseif gameState == 'play' then
        if key == 'escape' then
            sfx['escape']:play()
            gameState = 'serve'
        end
    elseif gameState == 'victory' then
        if key == 'return' or key == 'escape' then
            gameState = 'serve'
            sfx['select']:play()
            player1.score = 0
            player2.score = 0
        end
    end
end

-- Draw
function love.draw()
    push:start()
    -- Background
    r, g, b = 100, 70, 70
    love.graphics.clear(r/255, g/255, b/255, 1)


    -- TESTING CIRCLE 
    -- setRGB(245, 151, 49)
    -- love.graphics.circle('line', VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2, 100, 100)
    -- love.graphics.circle('fill', VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2, 99.5 , 100)



    if gameState == 'start' then
        displayWelcomeScreenTitle()
    elseif gameState == 'serve' then
        displayTitle()
        displayFPS()
        ball:render()
        player1:renderScore('top')
        player2:renderScore('bot')
        player1:renderPaddle()
        player2:renderPaddle()

        -- Serving player blink indicator
        if servingPlayer == 1 then
            if math.floor(love.timer.getTime() * 4) % 2 == 0 then
                setRGB(168, 84, 10)
                love.graphics.rectangle(
                    'fill',
                    player1.x,
                    player1.y,
                    player1.width,
                    player1.height
                )
            end
        elseif servingPlayer == 2 then
            if math.floor(love.timer.getTime() * 4) % 2 == 0 then
                setRGB(168, 84, 10)
                love.graphics.rectangle(
                    'fill',
                    player2.x,
                    player2.y,
                    player2.width,
                    player2.height
                )
            end
        end
    elseif gameState == 'play' then
        displayTitle()
        displayFPS()
        
        player1:renderScore('top')
        player2:renderScore('bot')
        player1:renderPaddle()
        player2:renderPaddle()
        ball:render()
    
    elseif gameState == 'victory' then
        -- displayTitle()
        displayVictoryScreen()
        player1:renderScore('top')
        player2:renderScore('bot')
        -- player1:renderPaddle()
        -- player2:renderPaddle()
        
    end
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

function displayWelcomeScreenTitle()
    setRGB(220, 220, 225)
        t = love.graphics.setFont(love.graphics.newFont('/fonts/noodle.ttf', 60))
        love.graphics.printf(
        'PongHub', 
        0, 
        VIRTUAL_HEIGHT/3, 
        VIRTUAL_WIDTH, 
        'center')

        love.graphics.setFont(love.graphics.newFont('/fonts/arcade.ttf', 12))
        love.graphics.printf(
        'Press Enter to play', 
        0, 
        VIRTUAL_HEIGHT/2 + 30, 
        VIRTUAL_WIDTH, 
        'center')

        love.graphics.setFont(love.graphics.newFont('/fonts/arcade.ttf', 8))
        love.graphics.printf(
        'Version: 1.0', 
        10, 
        VIRTUAL_HEIGHT - 15, 
        VIRTUAL_WIDTH, 
        'left')
end

function displayVictoryScreen()
    if winner == 1 then
        winner = 'Top dude'
    elseif winner == 2 then
        winner = 'Bottom dude'
    end
    love.graphics.setFont(love.graphics.newFont('/fonts/noodle.ttf', 40))
        love.graphics.printf(
        winner..' wins!', 
        0, 
        VIRTUAL_HEIGHT/2 - 30, 
        VIRTUAL_WIDTH, 
        'center')

    love.graphics.setFont(love.graphics.newFont('/fonts/arcade.ttf', 10))
        love.graphics.printf(
        'Press Enter to play again', 
        0, 
        VIRTUAL_HEIGHT/2 + 30, 
        VIRTUAL_WIDTH, 
        'center')
end
