require ("conf")
require ("bar")

--init value
isdestroy = false
net_state = "default"

--LOVE2D original callback functions start
function love.load(arg)--called before game start, only once
	print(_width)
	print(_height)

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

	if not isdestroy then
		love.graphics.setColor(72, 160, 14) 
  		love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
	end

	love.graphics.setColor(193, 47, 14) 
  	love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())

  	-- love.graphics.setColor(50, 50, 50) 
  	-- love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
  	-- love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
  	if net_state == "server" then
		testbar1:draw()
	end
end
 
function love.update(dt)--dt the time between function called
	world:update(dt)

	-- print(objects.ball.body:getX(),objects.ball.body:getY())
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
		print("u")
		objects.ball.body:applyForce(0, 400)
	elseif love.keyboard.isDown('down','s') then
		print("d")
		objects.ball.body:applyForce(0, -400)
	elseif love.keyboard.isDown('r') then
		print("destroy")
		if not isdestroy then
			isdestroy = true
			objects.ground.body:setActive(false)--important
			objects.ground.body:destroy()
		end
	elseif love.keyboard.isDown('t') then
		print("thread")
		if net_state == "server" then
			print("pop end"..channel:pop())
		elseif net_state == "client" then
			print("push start")
			channel:push("push in")
		end
	elseif love.keyboard.isDown('[') then
		if net_state == "default" then
			net_state = "server"
			thread = love.thread.newThread("server.lua")
   			channel = love.thread.getChannel("server")
   			thread:start()
		end
	elseif love.keyboard.isDown(']') then
		if net_state == "default" then
			net_state = "client"
			thread = love.thread.newThread("client.lua")
   			channel = love.thread.getChannel("client")
   			thread:start()
		end
	end
end