require ("conf")
require ("bar")

--LOVE2D original callback functions start
function love.load(arg)--called before game start, only once
	print(_width)
	print(_height)

	--global objects
	testbar1 = barGenerater:new()
	testbar2 = barGenerater:new()
	testbar2:init()

	love.physics.setMeter(5) --1px as 1 meter
	world = love.physics.newWorld(0, 9.81*5, true)

	objects = {} -- physical object
	--create ground
	objects.ground = {}
	objects.ground.body = love.physics.newBody(world, _width/2, _height-10/2)--the center of the object,not leftup
	objects.ground.shape = love.physics.newRectangleShape(_width, 10)
	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)

	objects.ball = {}
	objects.ball.body = love.physics.newBody(world, _width/2, _height/2, "dynamic")
	objects.ball.shape = love.physics.newCircleShape(5)
	objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1)
	objects.ball.fixture:setRestitution(0.7)

	-- objects.block1 = {}
	-- objects.block1.body = love.physics.newBody(world, 200, 550, "dynamic")
	-- objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
	-- objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5)
	
	-- objects.block2 = {}
	-- objects.block2.body = love.physics.newBody(world, 200, 650/2, "dynamic")
	-- objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
	-- objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)
end 

function love.draw()
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	-- rotate around the center of the screen by angle radians
	-- love.graphics.translate(_width/2, _height/2)
	-- love.graphics.rotate(angle)
	-- love.graphics.translate(-_width/2, -_height/2)

	love.graphics.setColor(72, 160, 14) 
  	love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))

	love.graphics.setColor(193, 47, 14) 
  	love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())

  	-- love.graphics.setColor(50, 50, 50) 
  	-- love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
  	-- love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))

	testbar1:draw()
end
 
function love.update(dt)--dt the time between function called
	world:update(dt)

	print(objects.ball.body:getX(),objects.ball.body:getY())
	-- love.timer.sleep(.01)
	
	keyboardDown()
end
--LOVE2D original callback functions end

function keyboardDown()
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	elseif love.keyboard.isDown('left','a') then
		print("l")
		objects.ball.body:applyForce(400, 0)
	elseif love.keyboard.isDown('right','d') then
		print("r")
		objects.ball.body:applyForce(-400, 0)
	elseif love.keyboard.isDown('up','w') then
		print("r")
		objects.ball.body:applyForce(0, 400)
	elseif love.keyboard.isDown('down','s') then
		print("r")
		objects.ball.body:applyForce(0, -400)
	end
end
