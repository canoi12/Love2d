sword=gameobject:new()

function sword:new(o)
	o = o or {}
	self:load()
	return setmetatable(o, {__index=self})
end

function sword:load()
	self.image = love.graphics.newImage("Assets/sword.png")
	self.image:setFilter("nearest","nearest")
	self.xorigin=2
	self.yorigin=12
	self.kind = 3
	self.swordcol = swordcol:new()

	self.attack = false

end

function sword:update(dt)
	if love.keyboard.isDown("z") then
		self.attack = true
	end

	if math.abs(self.angle) >= 130 then
		self.attack = false
	end
	--[[self.swordcol.x = self.x
	if self.flip == -1 then
		self.swordcol.x = self.x - 12
	end
	self.swordcol.y = self.y]]

	if self.attack then
		self.angle = utils.approach(self.angle, self.flip*130, 15)
	else
		self.angle = 0
	end
	self.swordcol:update(dt)
end

function sword:draw()
	love.graphics.draw(self.image,self.x,self.y,math.rad(self.angle),self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin)
	--love.graphics.rectangle("line",self.x+self.bbox.left-self.xorigin,self.y+self.bbox.top-self.yorigin, self.bbox.right,self.bbox.bottom)
	self.swordcol:draw()
end