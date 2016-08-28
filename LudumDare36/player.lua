require "spear"

player = gameobject:new({anim={}})

player.image = love.graphics.newImage("assets/man.png")
player.image:setFilter("nearest","nearest")

--player.footprints = {}

player.footTime = 0
player.footErase = 0

player.printFoot = false

function player:new(o)
	o = o or {}
	return setmetatable(o, {__index=self})
end

function player:load()
	player:createAnimation("idle",0,0,16,32,3)
	player:createAnimation("walk",0,32,16,32,8)
	player.x = 50
	player.y = 50
	self.footprints = screenmanager.screens["level"].footprints

	spear:load()
end

function player:move(dt)
	local keyLeft = love.keyboard.isDown("left") or (Joystick[1]:getAxis(1) < -0.4)
	local keyRight = love.keyboard.isDown("right") or (Joystick[1]:getAxis(1) > 0.4)
	local keyUp = love.keyboard.isDown("up") or (Joystick[1]:getAxis(2) < -0.4)
	local keyDown = love.keyboard.isDown("down") or (Joystick[1]:getAxis(2) > 0.4)
	local keyRun = love.keyboard.isDown("x") or (Joystick[1]:isDown(1))

	if keyRun then
		self.speed = 140
	else
		self.speed = 70
	end

	if keyLeft then
		self.dx = -(self.speed*dt)
		self.flip = -1
	elseif keyRight then
		self.dx = (self.speed*dt)
		self.flip = 1
	end

	if keyUp then
		self.dy = -(self.speed*dt)
	elseif keyDown then
		self.dy = (self.speed*dt)
	end

	if not(keyUp or keyDown) then
		self.dy = self.dy * self.friction
	end
	if not(keyLeft or keyRight) then
		self.dx = self.dx * self.friction
	end

	if (keyUp or keyDown) and (keyLeft or keyRight) then
		self.dx = self.dx/1.5
		self.dy = self.dy/1.5
	end

	if self.dx <= -0.1 or self.dx >= 0.1 or self.dy <= -0.01 or self.dy >= 0.01 then
		self:changeAnim("walk")
	else
		self:changeAnim("idle")

	end


	if self.footTime < 1.5 then
		self.footTime = self.footTime + 0.2
	else
		self.footTime = 0
		if self.actualAnim == "walk" then
			local yy = love.math.random()*6
			local xx = love.math.random()*4
			table.insert(self.footprints,foot:new{x=self.x+xx,y=self.y+2+yy})
		end
	end

	self.x = self.x + self.dx
	self.y = self.y + self.dy

	spear.x = self.x + (2*self.flip)
	spear.y = self.y + 4
	spear.flip = self.flip
	spear:update(dt)
end

function player:update(dt)
	self:playAnim()
	self:move(dt)
end

function player:draw()
	
	spear:draw()
	love.graphics.draw(self.image,self.anim[self.actualAnim][self.frame],self.x,self.y,self.angle,self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin,self.xske,self.yske)
end