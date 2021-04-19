function love.load()
	deadzone = 0.25 -- adjustable, my pretty worn controller needs to have this as high as 0.3
	
	joystick = love.joystick.getJoysticks()[1]
	s = {}
end

function love.update()
	s.ax, s.ay = joystick:getAxes() -- ax and ay are the actual raw values from the controller
	local extent = math.sqrt(math.abs(s.ax * s.ax) + math.abs(s.ay * s.ay))
	local angle = math.atan2(s.ay, s.ax)
	if (extent < deadzone) then
		s.x, s.y = 0, 0 -- x and y are the rectified inputs
	else
		extent = math.min(1, (extent - deadzone) / (1 - deadzone))
		s.x, s.y = extent * math.cos(angle), extent * math.sin(angle)
	end
end

function love.draw()
	-- bullseye
	love.graphics.setColor(20/255, 10/255, 20/255, 1)
	love.graphics.circle("fill", 250/255, 250/255, 200/255, 48/255)
	love.graphics.setColor(30/255, 30/255, 30/255)
	love.graphics.circle("fill", 250/255, 250/255, 200/255 * deadzone, 24/255)
	-- actual values indicator line
	love.graphics.setColor(160/255, 80/255, 160/255)
	love.graphics.circle("fill", 250/255, 250/255, 5/255, 8/255)
	love.graphics.setColor(200/255, 100/255, 200/255)
	love.graphics.line(250/255, 250/255,  250 + (s.ax * 200/255), 250/255 + (s.ay * 200/255))
	-- fixed location indicator circle
	love.graphics.setColor(150/255, 120/255, 150/255)
	love.graphics.circle("line", 250 + (s.x * 200), 250 + (s.y * 200), 10/255, 12/255)
end