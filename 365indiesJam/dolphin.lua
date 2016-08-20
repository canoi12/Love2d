dolphin=gameobject:new{anim={}}

function dolphin:new(o)
	o = o or {}
	o.quadrant = math.floor(o.x/global.width) + (math.floor(o.y/global.height)*(level1.map.test.width*level1.tilewidth)/global.width)
	self:load()
	return setmetatable(o, {__index=self})
end

function dolphin:collision(obj2)
	if self == obj2 or self.kind == obj2.kind or obj2.kind == 4 then
		return false
	end
	local ob1 = {
		x = self.bbox.left + self.x - self.xorigin,
		y = self.bbox.top + self.y - self.yorigin,
		w = self.bbox.right - self.bbox.left,
		h = self.bbox.bottom - self.bbox.top,
		flip = self.flip
	}
	ob1.xc = (ob1.x) + (ob1.w/2)
	ob1.yc = ob1.y + (ob1.h/2)
	local ob2 = {
		x = obj2.bbox.left + obj2.x - obj2.xorigin,
		y = obj2.bbox.top + obj2.y - obj2.yorigin,
		w = obj2.bbox.right - obj2.bbox.left,
		h = obj2.bbox.bottom - obj2.bbox.top,
		flip = obj2.flip
	}

	if obj2.flip == -1 and obj2.kind == 3 then
		ob2.xc = (ob2.x-12) + (ob2.w/2)
	else
		ob2.xc = (ob2.x) + (ob2.w/2)
	end
	ob2.yc = ob2.y + (ob2.h/2)

	local w = (ob1.w + ob2.w)/2
	local h = (ob1.h + ob2.h)/2

	local dx = ob1.xc - ob2.xc
	local dy = ob1.yc - ob2.yc

	if math.abs(dx) <= w and math.abs(dy) <= h then
		local wy = y * dy
		local hx = h * dx

		if self.kind == 3 or obj2.kind == 3 then
			return true
		end

		if wy > hx then
			if wy > -hx then
				--self.y = obj2.y + h
			else
				self.x = obj2.x - w
			end
		else
			if wy > -hx then
				self.x = obj2.x + w
			else
				--self.y = obj2.y - h
			end
		end
		return true
	end
	return false

end

function dolphin:load()
	self.image = love.graphics.newImage("Assets/dolphin.png")

	self:addAnim("idle",0,0,16,16,4)
	self:addAnim("walk",0,16,16,16,6)
	self.dx = 0
	self.bounce = 0.2
	self.animSpeed=0.25
	self.life = 3
	self.kind = 2
	self.image:setFilter("nearest","nearest")
	self.type = "dolphin"

	self.damageSound = love.audio.newSource("Assets/sounds/Hit_Hurt.wav","static")
	self.damageSound:setVolume(0.5)

	self.bbox = {
		left = 4,
		right = 12,
		top = 2,
		bottom = 16
	}
end

function dolphin:move()
	local xprevious = self.x
	local yprevious = self.y
	if not utils.check_solid(self.x, self.y+7) then
		self.dy = self.dy + self.gravity
	else
		--while map.tmap[math.floor(((self.y-9)/16))+1][math.floor((self.x)/16)] == gamescreen.map.test.tilesets[1].tiles[1].id+1 do
		while utils.check_solid(self.x,self.y+6) do
			self.y = self.y-1
		end
		self.dy = self.dy * -self.bounce
	end

	if not(utils.check_solid(self.x+screenmanager.currentScreen.tilewidth, self.y+screenmanager.currentScreen.tileheight)) and utils.check_solid(self.x,self.y+screenmanager.currentScreen.tileheight) then
		self.flip = -1
	elseif not(utils.check_solid(self.x-screenmanager.currentScreen.tilewidth, self.y+screenmanager.currentScreen.tileheight)) and utils.check_solid(self.x,self.y+screenmanager.currentScreen.tileheight)  then
		self.flip = 1
	end

	if utils.check_solid(self.x+8,self.y) then
		self.flip = -1
		self.dx = -1
	elseif utils.check_solid(self.x-8, self.y) then
		self.flip = 1
		self.dx = 1
	end

	if self.x <= math.abs(camera.x) then
		self.flip = 1 
		self.dx = 1
	elseif self.x >= math.abs(camera.x-global.width) then
		self.flip = -1
		self.dx = -1
	end
	if self.flip ~= 0 then
		self:setAnim("walk")
		--self.flip = self.dx
	else
		self:setAnim("idle")
	end


	-- Damage taken
	if self.damage then
		self.damageTime = self.damageTime - 0.05
	end

	if self.damageTime <= 0 then
		self.damage = false
		self.dx = 0
	end

	if self:collision(screenmanager.currentScreen.player.sword) then
		if screenmanager.currentScreen.player.sword.attack and not self.damage then
			self.damage = true
			self.damageTime = 1
			self.life = self.life - 1
			self.dy = -2
			self.dx = screenmanager.currentScreen.player.sword.flip * 1.2
			self.damageSound:play()
		end
	end

	if self.life <= 0 then
		self.destroy = true
	end

	if not self.damage then
		self.x = self.x + self.flip
	else
		self.x = self.x + self.dx
	end
	-- End damage taken
	self.y = self.y + self.dy
end

function dolphin:update(dt)
	self:playAnim()
	self:move()
end

function dolphin:draw()
	love.graphics.draw(self.image,self.anim[self.actualAnim][self.frame],self.x,self.y,self.angle,self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin)
	--love.graphics.print(self.quadrant, self.x, self.y)
	--love.graphics.rectangle("line",self.x+self.bbox.left-self.xorigin,self.y+self.bbox.top-self.yorigin, self.bbox.right,self.bbox.bottom)
end