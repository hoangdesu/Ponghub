class = require 'middleclass'

Car = class('Car')

function Car:initialize()
    self.name = 'merc'
    self.wheels = 4
end