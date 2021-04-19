Ball = class{}

function Ball:init(name)
    self.name = name
end

function Ball:add2()
    return self.name + 2
end