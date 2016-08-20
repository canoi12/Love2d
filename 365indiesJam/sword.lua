sword=gameobject:new()

function sword:new(o)
	o = o or {}
	self:load()
	return setmetatable(o, {__index=self})
end

function sword:collision(obj2)
	if self == obj2 then
		return false
	end
	local ob1 = {
		x = self.bbox.left + self.x - self.xorigin,
		y = self.bbox.top + self.y - self.yorigin,
		w = self.bbox.right - self.bbox.left,
		h = self.bbox.bottom - self.bbox.top,
		flip = self.flip
	}
	if self.flip == -1 then
		ob1.xc = (ob1.x-12) + (ob1.w/2)
	else
		ob1.xc = (ob1.x) + (ob1.w/2)
	end
	ob1.yc = ob1.y + (ob1.h/2)
	local ob2 = {
		x = obj2.bbox.left + obj2.x - obj2.xorigin,
		y = obj2.bbox.top + obj2.y - obj2.yorigin,
		w = obj2.bbox.right - obj2.bbox.left,
		h = obj2.bbox.bottom - obj2.bbox.top,
		flip = obj2.flip
	}

	if obj2.flip == -1 and obj2.kind == 3 then
		ob2.xc = (ob2.x-14) + (ob2.w/2)
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
				self.y = obj2.y + h
			else
				self.x = obj2.x - w
			end
		else
			if wy > -hx then
				self.x = obj2.x + w
			else
				self.y = obj2.y - h
			end
		end
		return true
	end
	return false
end

function sword:load()
	self.image = love.graphics.newImage("Assets/sword.png")
	self.image:setFilter("nearest","nearest")
	self.xorigin=2
	self.yorigin=12
	self.kind = 3
	self.swordcol = swordcol:new()
	self.atkCoolDown = 1
	self.bbox = {
		left = -2,
		right = 18,
		top = 0,
		bottom = 16
	}

	self.attack = false

	self.attackSound = love.audio.newSource("Assets/sounds/Sword.wav","static")
	self.attackSound:setVolume(0.5)

	oldKeyZ = false

end

function sword:update(dt)
	local keyZ = love.keyboard.isDown("z")


	if keyZ and self.atkCoolDown <= 0 and not(oldKeyZ) then
		self.attack = true
		self.attackSound:play()
	end

	oldKeyZ = keyZ

	if self.atkCoolDown > 0 then
		self.atkCoolDown = self.atkCoolDown - 0.1
	end

	if math.abs(self.angle) >= 130 and self.attack then
		self.attack = false
		self.atkCoolDown = 1
	end
	--[[self.swordcol.x = self.x
	if self.flip == -1 then
		self.swordcol.x = self.x - 12
	end
	self.swordcol.y = self.y]]

	if self.attack then
		self.angle = utils.approach(self.angle, self.flip*130, 20)
	else
		self.angle = 0
	end
	self.swordcol:update(dt)
end

function sword:draw()
	love.graphics.draw(self.image,self.x,self.y,math.rad(self.angle),self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin)
	--love.graphics.rectangle("line",self.x+self.bbox.left-self.xorigin,self.y+self.bbox.top-self.yorigin, self.bbox.right,self.bbox.bottom)
	self.swordcol:draw()
end