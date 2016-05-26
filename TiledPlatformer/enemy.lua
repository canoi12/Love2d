enemy = gameobject:new()

function enemy:new(x,y,width,height)
	o = {x=x,y=y,width=width,height=height,type='enemy'} or {}
	return setmetatable(o,{__index=self})
end

function enemy:walkState(dt)
	self.vspeed = self.vspeed + (self.gravity*dt)
	self.y = self.y + (self.vspeed * dt)
	if self.y + 32 > game.roomheight then
		self.y = game.roomheight-32
		self.vspeed = 0
	end	
	for i,b in ipairs(objects) do
		if funcs:col4Sides(self,b,dt) and self.y + self.width <= b.y then
			self.vspeed = 0
		end		
		if b == Amora and funcs:col4Sides(self,b,dt) and Amora.y + Amora.height <= self.y + 1 then
			print(funcs:col4Sides(self,b,dt))
			self.life = self.life - 1;
		end
	end
	self.x = funcs:Clamp(self.x,0,game.roomwidth-self.width)
	self.y = funcs:Clamp(self.y,0,game.roomheight-self.height)
end
enemy.state = enemy.walkState

function enemy:load()
end

function enemy:update(dt)
	if self.state ~= nil then
		self:state(dt)
	end
	if self.life <= 0 then
		for i,b in ipairs(objects) do
			if b == self then
				table.remove(objects,i)
			end
		end
	end
end

function enemy:draw()
	love.graphics.rectangle("line",self.x,self.y,self.width,self.height)
	love.graphics.print(self.life,self.x,self.y)
end