dolphin=gameobject:new{anim={}}

function dolphin:new(o)
	o = o or {}
	self.x=64
	self:load()
	return setmetatable(o, {__index=self})
end

function dolphin:load()
	self.image = love.graphics.newImage("Assets/dolphin.png")

	self:addAnim("idle",0,0,16,16,4)
	self:addAnim("walk",0,16,16,16,6)
	self.dx = 0
	self.bounce = 0.2
	self.animSpeed=0.25
	self.kind = 2

	self.image:setFilter("nearest","nearest")
end

function dolphin:move()
	local xprevious = self.x
	local yprevious = self.y
	if not utils.check_solid(self.x, self.y-10+16) then
		self.dy = self.dy + self.gravity
	else
		--while map.tmap[math.floor(((self.y-9)/16))+1][math.floor((self.x)/16)] == gamescreen.map.test.tilesets[1].tiles[1].id+1 do
		while utils.check_solid(self.x,self.y-11+16) do
			self.y = self.y-1
		end
		self.dy = self.dy * -self.bounce
	end

	if not(utils.check_solid(self.x+16, self.y+16)) and utils.check_solid(self.x,self.y+16) then
		self.flip = -1
	elseif not(utils.check_solid(self.x-16, self.y+16)) and utils.check_solid(self.x,self.y+16)  then
		self.flip = 1
	end

	if self.dx ~= 0 then
		self:setAnim("walk")
		--self.flip = self.dx
	else
		self:setAnim("idle")
	end

	if self.damage then
		self.damageTime = self.damageTime - 0.05
	end

	if self.damageTime <= 0 then
		self.damage = false
		self.dx = 0
	end

	if utils.collision(self, screenmanager.currentScreen.objects[1].sword) then
		if screenmanager.currentScreen.objects[1].sword.attack and not self.damage then
			self.damage = true
			self.damageTime = 1
			self.dy = -2
			self.dx = screenmanager.currentScreen.objects[1].sword.flip * 2
		end
	end

	if not self.damage then
		self.x = self.x + self.flip + self.dx
	else
		self.x = self.x + self.dx
		print(self.dx)
	end
	self.y = self.y + self.dy
end

function dolphin:update(dt)
	self:playAnim()
	self:move()
end

function dolphin:draw()
	love.graphics.draw(self.image,self.anim[self.actualAnim][self.frame],self.x,self.y,self.angle,self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin)
	--love.graphics.rectangle("line",self.x+self.bbox.left-self.xorigin,self.y+self.bbox.top-self.yorigin, self.bbox.right,self.bbox.bottom)
end