local gameobject={}

gameobject.x = 0
gameobject.y = 0
gameobject.w = 8
gameobject.y = 8

gameobject.dx = 0
gameobject.dy = 0

gameobject.grav = 0.1

gameobject.friction = 0.2
gameobject.bounce = 0.8

gameobject.anim = {}
gameobject.xscale = 1
gameobject.yscale = 1
gameobject.flip = 1
gameobject.angle = 0

gameobject.frame = 1
gameobject.animTime = 0
gameobject.animName = "idle"

gameobject.xorigin = 4
gameobject.yorigin = 4

gameobject.xshearing = 	0
gameobject.yshearing = 0

gameobject.image = nil

gameobject.isGround = false

function gameobject:createAnim(name,x,y,frameWidth,frameHeight,numberImages)
	self.anim[name] = {}
	local frameX = x/frameWidth
	for i=frameX,(numberImages+frameX) do
		table.insert(self.anim[name],love.graphics.newQuad(i*frameWidth,y,frameWidth,frameHeight,self.image:getDimensions()))
	end
end

function gameobject:playAnim(name)
	if self.animName ~= name then
		self.animName = name
		self.frame = 1
	end
end

function gameobject:new(o)
	o = o or {}
	o.image:setFilter("nearest","nearest")
	return setmetatable(o, {__index = self})
end

function gameobject:load()

end

function gameobject:update(dt)

	if self.animTime < 1 then
		self.animTime = self.animTime + 0.2
	else
		self.animTime = 0
		self.frame = self.frame + 1
	end

	if self.frame >= table.getn(self.anim[self.animName]) then
		self.frame = 1
	end

	local keyLeft = love.keyboard.isDown("left")
	local keyRight = love.keyboard.isDown("right")
	local keyUp = love.keyboard.isDown("up")

	if keyRight then
		self.dx = (50 * dt)
		self.flip = 1
		--self:playAnim("walk")
	elseif keyLeft then	
		self.dx = -(50*dt)
		self.flip = -1
		--self:playAnim("walk")
	end

	if not keyLeft and not keyRight then
		self.dx = self.dx * self.friction
		--self:playAnim("idle")
	end

--[[[<<<<<<< HEAD
	if utils.check_solid(self.x, self.y + 2 + self.dy) then
=======]]
	if (keyLeft or keyRight) and self.isGround then
		self:playAnim("walk")
	elseif not(keyLeft or keyRight) and self.isGround then
		self:playAnim("idle")
	elseif not self.isGround then
		if self.dy > 0 then
			self:playAnim("fall")
		elseif self.dy < 0 then
			self:playAnim("jump")
		end
	end

	--if map.tmap[math.floor(self.y/8)+1][math.floor(self.x/8)] == 2 then
	if not utils.check_solid(self.x+math.abs(self.dx), self.y+2+self.dy) and not utils.check_solid(self.x-math.abs(self.dx),self.y+2+self.dy) then
		self.dy = self.dy + self.grav
		self.isGround = false
	else
		while utils.check_solid(self.x,self.y+1+self.dy) do
			self.y = self.y - 1
		end
-->>>>>>> a03cc97e9e424f6ff5abd12f4377df4b457e0b94
		self.dy = 0
		if not self.isGround then
			self.xscale = 1.4
			self.yscale = 0.4
			self.isGround = true
		end
		if keyUp then
			self.dy = -1.5
			self.xscale = 0.4
			self.yscale = 1.4
		end
	end

	if utils.check_solid(self.x-2+self.dx,self.y) or utils.check_solid(self.x+2+self.dx,self.y) then
		while utils.check_solid(self.x-2,self.y) do
			self.x = self.x + 1
		end
		while utils.check_solid(self.x+2,self.y) do
			self.x = self.x - 1
		end
		self.dx = 0
	end

	if utils.check_solid(self.x-4+self.dx,self.y) then
		self.dx = 0
	end
	if utils.check_solid(self.x+4+self.dx,self.y) then
		self.dx = 0
	end

	self.x = self.x + self.dx
	self.y = self.y + self.dy

--<<<<<<< HEAD
	--self.x = math.max(4,math.min(self.x,124))
--=======
	self.xscale = utils.approach(self.xscale,1,0.1)
	self.yscale = utils.approach(self.yscale,1,0.1)

	self.x = math.max(4,math.min(self.x,192-4))
	self.y = math.max(4,math.min(self.y,192-4))
-->>>>>>> a03cc97e9e424f6ff5abd12f4377df4b457e0b94

end

function gameobject:draw()
	love.graphics.draw(self.image,self.anim[self.animName][self.frame],self.x,self.y,self.angle,self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin,self.xshearing,self.yshearing)
end

return gameobject