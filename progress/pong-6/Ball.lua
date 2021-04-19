Class = require '/lib/middleclass'

Ball = Class('Ball')

function Ball:initialize(size)
    self.width = size
    self.height = size
    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = VIRTUAL_HEIGHT / 2
    self.dx = math.random(-50, 50)
    self.dy = math.random(2) == 0 and 100 or -100
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