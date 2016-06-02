require ("conf")
objectsGenerater={object_count = 0} -- a single object
function objectsGenerater:new()
	self.object_count = self.object_count+1
	print("object_count"..self.object_count)
	objects = {tag = "tag"..self.object_count}

	function objects:init(w)
		objectsManager:add(self,self.tag)
	end
	function objects:draw()
	end
	function objects:update() -- control or AI performance
	end
	function objects:remove() -- destroy self
		self.body:destroy()
		objectsManager:remove(self.tag)
		self=nil
	end
	return objects
end

objectsManager = {objectList = {},tagList = {}} -- manager all the objects, contain an object like set 
function objectsManager:add(object,tag)
	print("add"..tag)
	table.insert(self.objectList,object)
	table.insert(self.tagList,tag)
	print("#objectList"..#self.objectList)
end
function objectsManager:remove(tag)
	print("tag"..tag)
	for i=1,#self.tagList,1 do
		print("i"..i.."tag"..tag)
		if self.tagList[i] == tag then
			print(""..i)
			table.remove(self.objectList,i)
			table.remove(self.tagList,i)
			break
		end
	end
	print("#tagList"..#self.tagList)
end