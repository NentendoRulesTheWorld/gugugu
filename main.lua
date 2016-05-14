local angle = 0

function love.load(arg)

end 

function love.draw()
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	-- rotate around the center of the screen by angle radians
	love.graphics.translate(width/2, height/2)
	love.graphics.rotate(angle)
	love.graphics.translate(-width/2, -height/2)
	-- draw a white rectangle slightly off center
	love.graphics.setColor(0xff, 0xff, 0xff)
	love.graphics.rectangle('line', width/2-100, height/2-100, 300, 400)
	love.graphics.rotate(0)
	love.graphics.rectangle('fill', width/2-100, height/2-100, 250, 350)
end
 
function love.update(dt)
	love.timer.sleep(.01)
	angle = angle + dt * math.pi/2
	angle = angle % (2*math.pi)
end
