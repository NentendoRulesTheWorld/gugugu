barGenerater={}
function barGenerater:new()
	tmpbar = {positionX = 0,positionY = 0,length = 20,height = 10,color={0x55, 0x55, 0x55}}
	function tmpbar:init()
		print("init")
	end
	function tmpbar:draw()
		love.graphics.setColor(0xff, 0xff, 0xff)
		love.graphics.rectangle('line', self.positionX, self.positionY, self.height, self.length)
		love.graphics.setColor(self.color)
		love.graphics.rectangle('fill', self.positionX, self.positionY, self.height, self.length-10)
	end
	return tmpbar
end
