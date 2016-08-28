camel = gameobject:new({anim={}})

camel.walk = false
camel.walkTime = 0

camel.walkPoint = {}
local odds = 0

function camel:new(o)
	o = o or {}
	o.walkPoint = {}
	self:load()
	return setmetatable(o, {__index=self})
end

function camel:load()
	self.image = love.graphics.newImage("assets/camel-sheet.png")
	self.image:setFilter("nearest","nearest")

	self:createAnimation("idle",0,0,32,32,1)
	self:createAnimation("walk",0,32,32,32,6)
	self.xorigin = 16
	self.yorigin = 16

end

function camel:update(dt)
	self:playAnim()
	if self.walkTime < 10 then
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
		self.dx = utils.sign(self.walkPoint.x-self.x)
		self.dy = utils.sign(self.walkPoint.y-self.y)
	end
	if self.dx ~= 0 or self.dy ~= 0 then
		if self.dx ~= 0 then
			self.flip = -self.dx
			self:changeAnim("walk")
		end
	else
		self:changeAnim("idle")
	end

	self.x = self.x + self.dx
	self.y = self.y + self.dy

end

function camel:draw()
	love.graphics.draw(self.image,self.anim[self.actualAnim][self.frame],self.x,self.y,self.angle,self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin,self.xske,self.yske)
end