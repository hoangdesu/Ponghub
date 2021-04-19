function love.load()
    joystick = love.joystick.getJoysticks()[1]
    s = {}
end

function love.update(dt)
    s.x, s.y = joystick:getAxes()
    print(joystick:getAxes())

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    love.graphics.setBackgroundColor(30/255, 30/255, 30/255)
end