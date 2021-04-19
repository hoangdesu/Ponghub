Class = require '/lib/middleclass'

Ball = Class('Ball')

function Ball:initialize(size)
    self.width = size
    self.height = size
    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = VIRTUAL_HEIGHT / 2
    self.dx = math.random(-BALL_DX_RANGE, BALL_DX_RANGE)
    self.dy = math.random(2) == 0 and BALL_DY_RANGE or -BALL_DY_RANGE
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
    if self.x < 0 or self.x > VIRTUAL_WIDTH - self.width then
        self.dx = -self.dx
    end
end


function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = VIRTUAL_HEIGHT / 2
    self.dx = math.random(-70, 70)
    self.dy = math.random(2) == 2 and 150 or -150
end


function Ball:render()
    setRGB(209, 58, 27)
    love.graphics.rectangle(
        'fill',
        self.x,
        self.y,
        self.width,
        self.height
    )
end