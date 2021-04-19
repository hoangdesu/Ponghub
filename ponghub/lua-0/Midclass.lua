class = require 'middleclass'

Person = class('Person')

function Person:initialize(name)
    self.name = name
end