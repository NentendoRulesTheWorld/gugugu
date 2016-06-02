require ("conf")
require ("bar")
require ("objects")
-- require ("objectsContainer")

--LOVE2D original callback functions start
function love.load(arg)--called before game start, only once
	--global init
	host_state = "default"

	testbar1 = barGenerater:new()
	testbar2 = barGenerater:new()
	testbar2:init()

	love.physics.setMeter(5) --1px as 1 meter
	world = love.physics.newWorld(0, 0, true)

	player = objectsGenerater:new()
	function player:init(w)
		self.body = love.physics.newBody(w, _width/2, _height/2, "dynamic")
		self.body:setLinearDamping(1)
		self.shape = love.physics.newCircleShape(5)
		self.fixture = love.physics.newFixture(self.body, self.shape, 1)
		self.fixture:setRestitution(0.7)
		objectsManager:add(self,self.tag)
	end
	function player:draw()
		love.graphics.setColor(193, 47, 14) 
  		love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
	end
	function player:update()
		if love.keyboard.isDown('left','a') then
			player.body:applyForce(400, 0)
		elseif love.keyboard.isDown('right','d') then
			player.body:applyForce(-400, 0)
		end
		if love.keyboard.isDown('up','w') then
			player.body:applyForce(0, 400)
		elseif love.keyboard.isDown('down','s') then
			player.body:applyForce(0, -400)
		end
	end
	player:init(world)

	npc = objectsGenerater:new()
	function npc:init(w)
		self.body = love.physics.newBody(w, 10, 10, "dynamic")
		self.body:setLinearDamping(1)
		self.shape = love.physics.newCircleShape(5)
		self.fixture = love.physics.newFixture(self.body, self.shape, 1)
		self.fixture:setRestitution(0.7)
		objectsManager:add(self,self.tag)
	end
	function npc:draw()
		love.graphics.setColor(193, 47, 14) 
  		love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
	end
	npc:init(world)

	ground = objectsGenerater:new()
	function ground:init(w)
		self.body = love.physics.newBody(w, _width/2, _height-10/2) --the center of the object,not leftup
		self.shape = love.physics.newRectangleShape(_width, 10)
		self.fixture = love.physics.newFixture(self.body, self.shape)
		objectsManager:add(self,self.tag)
	end
	function ground:draw()
		love.graphics.setColor(72, 160, 14) 
  		love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
	end
	ground:init(world)
	

end 

function love.draw()
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()

	for i=1,#objectsManager.objectList,1 do
		objectsManager.objectList[i]:draw()
	end

	testbar1:draw()
end
 
function love.update(dt)--dt the time between function called
	world:update(dt)
	-- love.timer.sleep(.01)
	for i=1,#objectsManager.objectList,1 do
		objectsManager.objectList[i]:update()
	end

	keyboardDown()
end
--LOVE2D original callback functions end

function keyboardDown()
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

	if love.keyboard.isDown('r') then
		if ground then
			print("destroy")
			ground:remove()
			ground=nil
		end
	elseif love.keyboard.isDown('t') then
		print("thread")
		if host_state == "server" then
			print("pop end"..channel:pop())
		elseif host_state == "client" then
			print("push start")
			channel:push("push in")
		end
	elseif love.keyboard.isDown('[') then
		if host_state == "default" then
			host_state = "server"
			thread = love.thread.newThread("server.lua")
   			channel = love.thread.getChannel("server")
   			thread:start()
		end
	elseif love.keyboard.isDown(']') then
		if host_state == "default" then
			host_state = "client"
			thread = love.thread.newThread("client.lua")
   			channel = love.thread.getChannel("client")
   			thread:start()
		end
	end
end