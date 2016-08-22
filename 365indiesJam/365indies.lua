indie = gameobject:new{x=1856,y=216}
indie.spawnPart = 1

function indie:new(o)
	o = o or {}
	self:load()
	return setmetatable(o, {__index=self})
end

function indie:load()
	self.image = love.graphics.newImage("Assets/365indies.png")
	self.image:setFilter("nearest","nearest")
	self.dy = -math.pi
	self.xorigin = 16
	self.yorigin = 16
	self.partimage = love.graphics.newImage("Assets/heart.png")
end

function indie:update(dt)
	self.dy = self.dy + 0.1
	if self.dy % math.pi*2 == 0 then
		self.dy = 0
	end
	if self.spawnPart > 0 then
		self.spawnPart = self.spawnPart - 1
	else
		self.spawnPart = 1
		table.insert(screenmanager.screens["level1"].particles,particle:new{quadrant=self.quadrant,x=love.math.random(self.x-8,self.x+16),y=self.y+8,bounce=0.0,dy=0,speed=love.math.random()*2,angle=math.rad(270),life=15,gravity = 0,image=self.partimage})
	end
	self.y = (self.y + (math.sin(self.dy)*0.15))
end

function indie:draw()
	love.graphics.draw(self.image,self.x,self.y,self.angle,self.xscale,self.yscale,self.xorigin,self.yorigin)
end