player = gameobject:new({anim={}})

player.image = love.graphics.newImage("assets/man.png")
player.image:setFilter("nearest","nearest")

player.footprints = {}

player.footTime = 0
player.footErase = 0


function player:new(o)
	o = o or {}
	return setmetatable(o, {__index=self})
end

function player:load()
	player:createAnimation("idle",0,0,16,32,3)
	player:createAnimation("walk",0,32,16,32,8)
end

function player:move(dt)
	local keyLeft = love.keyboard.isDown("left")
	local keyRight = love.keyboard.isDown("right")
	local keyUp = love.keyboard.isDown("up")
	local keyDown = love.keyboard.isDown("down")

	if keyLeft then
		self.dx = -(70*dt)
		self.flip = -1
	elseif keyRight then
		self.dx = (70*dt)
		self.flip = 1
	end

	if keyUp then
		self.dy = -(70*dt)
	elseif keyDown then
		self.dy = (70*dt)
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
			table.insert(self.footprints,{x=self.x+love.math.random()*4,y=self.y+love.math.random()*8})
		end
	end

	if self.footErase < 5 then
		self.footErase = self.footErase + 0.5
	else
		table.remove(self.footprints,1)
		self.footErase = 0
	end
	if table.getn(self.footprints) >= 20 then
		table.remove(self.footprints,1)
	end

	self.x = self.x + self.dx
	self.y = self.y + self.dy
end

function player:update(dt)
	self:playAnim()
	self:move(dt)
end

function player:draw()
	love.graphics.setColor(171,82,54,255)
	for i,v in ipairs(self.footprints) do
		love.graphics.ellipse("fill",v.x,v.y+8,2,1)
	end
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(self.image,self.anim[self.actualAnim][self.frame],self.x,self.y,self.angle,self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin,self.xske,self.yske)
end