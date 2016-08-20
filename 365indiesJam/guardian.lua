guardian = gameobject:new{x=976,y=362}

function guardian:new(o)
	o = o or {}
	self:load()
	return setmetatable(o, {__index=self})
end

function guardian:load()
	self.image = love.graphics.newImage("Assets/guardiao.png")
	self.image:setFilter("nearest","nearest")
	self.dy = -math.pi
end

function guardian:update(dt)
	self.dy = self.dy + 0.1
	if self.dy % math.pi*2 == 0 then
		self.dy = 0
	end
	self.y = (self.y + (math.sin(self.dy)*0.15))
end

function guardian:draw()
	love.graphics.draw(self.image,self.x,self.y,self.angle,self.xscale,self.yscale,self.xorigin,self.yorigin)
end