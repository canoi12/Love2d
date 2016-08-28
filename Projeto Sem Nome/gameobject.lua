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

function gameobject:createAnim(name,x,y,frameWidth,frameHeight,numberImages)
	self.anim[name] = {}
	local frameX = x/frameWidth
	for i=frameX,(numberImages+frameX) do
		table.insert(self.anim[name],love.graphics.newQuad(i*frameWidth,y,frameWidth,frameHeight,self.image:getDimensions()))
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
	elseif keyLeft then	
		self.dx = -(50*dt)
		self.flip = -1
	end

	if not keyLeft and not keyRight then
		self.dx = self.dx * self.friction
	end

	if utils.check_solid(self.x, self.y + 2 + self.dy) then
		self.dy = 0
		if keyUp then
			self.dy = -1.5
		end
	else
		self.dy = self.dy + self.grav
	end

	if utils.check_solid(self.x-4+self.dx,self.y) then
		self.dx = 0
	end
	if utils.check_solid(self.x+4+self.dx,self.y) then
		self.dx = 0
	end

	self.x = self.x + self.dx
	self.y = self.y + self.dy

	self.x = math.max(4,math.min(self.x,124))

end

function gameobject:draw()
	love.graphics.draw(self.image,self.anim[self.animName][self.frame],self.x,self.y,self.angle,self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin,self.xshearing,self.yshearing)
end

return gameobject