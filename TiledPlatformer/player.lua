player = gameobject:new{x=32,y=0}

function player:walkState(dt)
	self.vspeed = self.vspeed + (self.gravity*dt)
	self.y = self.y + (self.vspeed * dt)
	if self.y + 32 > game.roomheight then
		self.y = game.roomheight-self.height
		self.vspeed = 0
	end

	if love.keyboard.isDown("right") then
		self.x = self.x + (self.speed*dt)
	elseif love.keyboard.isDown("left") then
		self.x = self.x - (self.speed*dt)
	end

	for i,b in ipairs(objects) do
		funcs:col4Sides(self,b,dt)
	end

	if love.keyboard.isDown("up") and self.vspeed == 0 then
		self.vspeed = -400
	end

	self.x = funcs:Clamp(self.x,0,game.roomwidth-self.width)
	self.y = funcs:Clamp(self.y,0,game.roomheight-self.height)
end

function player:new(o)
	o = o or {}
	return setmetatable(o,{__index = self})
end

function player:load()
	self.state = player.walkState
end

function player:update(dt)
	if self.state ~= nil then
		self:state(dt)
	end
end

function player:draw()
	love.graphics.rectangle("line",self.x,self.y,self.width,self.height)
end	