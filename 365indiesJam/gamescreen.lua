gamescreen={}
gamescreen.map={}
gamescreen.objects={}


function gamescreen:new(o)
	o = o or {}
	self:load()
	return setmetatable(o, {__index=self})
end

function gamescreen:load()
	self.map = map:new()
	self.objects={}
end

function gamescreen:getObjects()
	for j,datav in ipairs(self.map.test.layers) do
		if datav.type == "objectgroup" then
			for i,v in ipairs(datav.objects) do
				if v.name == "Dolphin" then
					table.insert(self.objects,dolphin:new{x=v.x,y=v.y})
				end
			end
		end
	end
end

function gamescreen:reset()
end

function gamescreen:update(dt)
end

function gamescreen:draw()
end