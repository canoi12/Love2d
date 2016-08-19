powerup=gameobject:new()

function powerup:new(o)
	o = o or {}
	self:load()
	return setmetatable(o, {__index=self})
end

function powerup:load()
	self.kind = 5
	self.image = love.graphics.newImage("Assets/power-up.png")
	self.image:setFilter("nearest","nearest")
end

function powerup:update(dt)
	self.dy = self.dy + 0.1
	if self.dy % math.pi*2 == 0 then
		self.dy = 0
	end

	self.y = (self.y + (math.sin(self.dy)*0.2))
end

function powerup:draw()
	love.graphics.draw(self.image, self.x, self.y,self.angle,self.xscale,self.yscale,self.xorigin,self.yorigin)
end