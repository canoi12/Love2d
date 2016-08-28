enemy = gameobject:new({anim={}})

enemy.walk = false
enemy.walkTime = 0

enemy.walkPoint = {}
local odds = 0

enemy.footTime = 0
enemy.footErase = 0

function enemy:new(o)
	o = o or {}
	o.walkPoint = {}
	--self:load()
	return setmetatable(o, {__index=self})
end

function enemy:load()
	self.footprints = screenmanager.screens["level"].footprints
end

function enemy:walkArround(dt)
	if self.walkTime < 10 then
		self.walkTime = self.walkTime + 0.1
	else
		odds = love.math.random(2)
		if odds == 1 then
			self.walk = true
			self.walkPoint.x = love.math.random(global.roomWidth)
			self.walkPoint.y = love.math.random(global.roomHeight)
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
			table.insert(self.footprints,foot:new{x=self.x+love.math.random()*4,y=self.y+love.math.random()*8,destroy=true,erase=200})
		end
	end

	self.x = self.x + self.dx
	self.y = self.y + self.dy
end

function enemy:update(dt)
	--self:playAnim()
end

function enemy:draw()
	--love.graphics.draw(self.image,self.anim[self.actualAnim][self.frame],self.x,self.y,self.angle,self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin,self.xske,self.yske)
end