dolphin=gameobject:new{anim={}}

function dolphin:new(o)
	o = o or {}
	self.x=64
	self:load()
	return setmetatable(o, {__index=self})
end

function dolphin:load()
	self.image = love.graphics.newImage("Assets/dolphin.png")

	self:addAnim("idle",0,0,16,16,4)
	self:addAnim("walk",0,16,16,16,6)

	self.image:setFilter("nearest","nearest")
end

function dolphin:move()
	if not utils.check_solid(self.x, self.y-10+16) then
		self.dy = self.dy + self.gravity
	else
		--while map.tmap[math.floor(((self.y-9)/16))+1][math.floor((self.x)/16)] == gamescreen.map.test.tilesets[1].tiles[1].id+1 do
		while utils.check_solid(self.x,self.y-11+16) do
			self.y = self.y-1
		end
		self.dy = self.dy * -self.bounce
	end

	if not utils.check_solid(self.x+16, self.y+16) then
		self.dx = -1
	elseif not utils.check_solid(self.x-16, self.y+16) then
		self.dx = 1
	end

	if self.dx ~= 0 then
		self:setAnim("walk")
		self.flip = self.dx
	else
		self:setAnim("idle")
	end

	self.x = self.x + self.dx
	self.y = self.y + self.dy
end

function dolphin:update(dt)
	self:playAnim()
	self:move()
end

function dolphin:draw()
	love.graphics.draw(self.image,self.anim[self.actualAnim][self.frame],self.x,self.y,0,self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin)
end