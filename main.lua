require ("conf")
require ("bar")
local angle = 0

--LOVE2D original callback functions start
function love.load(arg)--called before game start, only once
print(_width)
print(_height)

--global objects
testbar1 = barGenerater:new()
testbar2 = barGenerater:new()
testbar2:init()

end 

function love.draw()
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	-- rotate around the center of the screen by angle radians
	love.graphics.translate(_width/2, _height/2)
	love.graphics.rotate(angle)
	love.graphics.translate(-_width/2, -_height/2)
	-- draw a white rectangle slightly off center
	love.graphics.setColor(0xff, 0xff, 0xff)
	-- love.graphics.rectangle('line', _width/2, _height/2, _width/8, _width/8)
	-- love.graphics.rectangle('line', 0, 0, _width/8, _width/8)
	-- love.graphics.rectangle('fill', _width/2, _height/2, _height/8, _height/8)
	love.graphics.setPointSize(5)
	love.graphics.setColor(0, 0, 0xff)
	love.graphics.point(6, 10)

	testbar1:draw()
end
 
function love.update(dt)--dt the time between function called
	-- print(dt)

	-- love.timer.sleep(.01)
	--angle = angle + dt * math.pi/2
	--angle = angle % (2*math.pi)

	keyboardDown()
end
--LOVE2D original callback functions end

function keyboardDown()
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	elseif love.keyboard.isDown('left','a') then
		angle = angle + 0.1
		print(angle)
	elseif love.keyboard.isDown('right','d') then
		angle = angle - 0.1
	end
end
