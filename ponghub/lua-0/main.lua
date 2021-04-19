-- print("hello Lua and LOVE2D")
-- math.randomseed(os.time()) -- random initialize
-- math.random(); math.random(); math.random() -- warming up

-- a = 20
-- b = math.random(a)
-- c = math.random(a)

-- print(math.random(2))
local class = require 'middleclass'


require 'Paddle'

p1 = Paddle:new('Brian')

print(p1.name)

p1.name = 'Cún'
print(p1.name)