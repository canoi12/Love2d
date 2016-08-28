lion = enemy:new({anim={}})

lion.walk = false
lion.walkTime = 0

lion.walkPoint = {}
local odds = 0

lion.footTime = 0
lion.footErase = 0

function lion:new(o)
	o = o or {}
	o.walkPoint = {}
	self:load()
	return setmetatable(o, {__index=self})
end

function lion:load()
	enemy.load(self)
	--enemy:load()
	self.image = love.graphics.newImage("assets/lion.png")
	self.image:setFilter("nearest","nearest")

	self:createAnimation("idle",0,0,32,32,1)
	self:createAnimation("walk",0,32,32,32,6)
	self.xorigin = 16
	self.yorigin = 16

	--self.footprints = screenmanager.screens["level"].footprints

end

function lion:update(dt)
	self:playAnim()
	--[[if self.walkTime < 10 then
		self.walkTime = self.walkTime + 0.1
	else
		odds = love.math.random(2)
		if odds == 1 then
			self.walk = true
			self.walkPoint.x = love.math.random(640)
			self.walkPoint.y = love.math.random(480)
		else
			self.walk = false
			self.dx = 0
			self.dy = 0
		end
		self.walkTime = 0
	end

	if self.walk then
		self.dx = utils.sign(self.walkPoint.x-self.x)*(50*dt)
		self.dy = utils.sign(self.walkPoint.y-self.y)*(50*dt)
	end
	if self.dx ~= 0 or self.dy ~= 0 then
		if self.dx ~= 0 then
			self.flip = -utils.sign(self.dx)
			self:changeAnim("walk")
		end
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

	if self.footErase < 10 then
		self.footErase = self.footErase + 0.5
	else
		table.remove(self.footprints,1)
		self.footErase = 0
	end]]
	self:walkArround(dt)
	--[[self.x = self.x + self.dx
	self.y = self.y + self.dy]]

end

function lion:draw()
	love.graphics.draw(self.image,self.anim[self.actualAnim][self.frame],self.x,self.y,self.angle,self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin,self.xske,self.yske)
end