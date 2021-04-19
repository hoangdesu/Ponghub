Class = require '/lib/middleclass'

Paddle = Class('Paddle')

function Paddle:initialize(player, width, height)
    self.width = width
    self.height = height
    -- self.x = math.random(VIRTUAL_WIDTH - self.width)
    self.x = VIRTUAL_WIDTH/2 - self.width/2
    if player == 'top' then
        self.y = VIRTUAL_HEIGHT/5
    elseif player == 'bot' then 
        self.y = VIRTUAL_HEIGHT -30
    end
    self.dx = 0
    self.score = 0
    
end

function Paddle:update(dt)
    if self.dx < 0 then
        self.x = math.max(0, self.x - (-self.dx) * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
end

function Paddle:renderScore(player)
    if player == 'top' then
        position = 'left'
        scoreX = 50
    elseif player == 'bot' then
        position = 'right'
        scoreX = -scoreX
    end
    setRGB(230, 255, 224)
    love.graphics.setFont(scoreFont)
    love.graphics.printf(
    tostring(self.score), 
    scoreX, 
    15, 
    VIRTUAL_WIDTH,
    position)
end

function Paddle:reset()
    -- self.x = math.random(VIRTUAL_WIDTH - self.width)
    self.x = VIRTUAL_WIDTH/2 - self.width/2

end

function Paddle:renderPaddle()
    setRGB(230, 255, 224)
    love.graphics.rectangle(
        'fill',
        self.x,
        self.y,
        self.width,
        self.height
    )
end