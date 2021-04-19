local class = require 'middleclass'

Paddle = class('Paddle')

function Paddle:initialize(name)
    self.name = name
end

function Paddle:print(hi)
    print(self.hi)
end
