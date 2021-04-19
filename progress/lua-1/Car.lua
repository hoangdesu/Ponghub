Car = Class{}

function Car:init(name)
    self.name = name
    self.wheels = 4
end

function Car:getName()
    return self.name
end