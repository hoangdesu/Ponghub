Class = require '/lib/middleclass'

Ball = Class('Ball')

function Ball:initialize(size)
    self.width = size
    self.height = size
    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = VIRTUAL_HEIGHT / 2
    self.dx = 0
    self.dy = 0
end

function Ball:collides(paddle)
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    elseif self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end
    return true
end

function Ball:bounce()
    if self.x < 0 then
        self.x = 0
        self.dx = -self.dx
        sfx['wall_hit']:play()
    elseif self.x > VIRTUAL_WIDTH - self.width then
        self.x = VIRTUAL_WIDTH - self.width
        self.dx = -self.dx
        sfx['wall_hit']:play()
    end
end


function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:reset(player1, player2)
    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = (player1.y + player2.y) / 2
    self.dx = math.random(-BALL_DX_RANGE, BALL_DX_RANGE)
    self.dy = math.random(70, BALL_DY_RANGE) 
end

function Ball:render()
    setRGB(245, 151, 49)
    love.graphics.rectangle(
        'fill',
        self.x,
        self.y,
        self.width,
        self.height
    )
end