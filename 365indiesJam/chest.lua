chest = gameobject:new{x=976,y=362,anim={}}
chest.open = false
chest.insideimage = {
	["batata"] = love.graphics.newImage("Assets/batata.png"),
	["doce"] = love.graphics.newImage("Assets/doce.png")
}

function chest:new(o)
	o = o or {}
	self:load()
	--[[if o.type == "batata" then
		o.insideimage = 
	elseif o.type == "doce" then
		o.insideimage = 
	end
	if o.insideimage ~= nil then
		o.insideimage:setFilter("nearest","nearest")
	end]]
	return setmetatable(o, {__index=self})
end

function chest:collision(obj2)
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

		if wy > hx then
			if wy > -hx then
				--self.y = obj2.y + h
			else
				--self.x = obj2.x - w
			end
		else
			if wy > -hx then
				--self.x = obj2.x + w
			else
				--self.y = obj2.y - h
			end
		end
		return true
	end
	return false
end

function chest:load()
	self.image = love.graphics.newImage("Assets/bau.png")
	self.image:setFilter("nearest","nearest")
	self.dy = -math.pi
	self:addAnim("idle",0,0,16,16,2)
	self.insideimage["batata"]:setFilter("nearest","nearest")
	self.insideimage["doce"]:setFilter("nearest","nearest")
end

function chest:update(dt)
	self.dy = self.dy + 0.1
	if self.dy % math.pi*2 == 0 then
		self.dy = 0
	end
	if not self.open then
		self.frame = 1
	else
		self.frame = 2
	end

	if self.type == "batata" or self.type == "doce" then
		if self:collision(screenmanager.screens["level1"].player) and love.keyboard.isDown("down") then
			self.open = true
		end
	else
		if self:collision(screenmanager.screens["level1"].player) and not screenmanager.screens["level1"].player.firesword then
			if love.keyboard.isDown("down") then
				global.write = true
			end
			if string.lower(global.senha) == "batata doce" or string.lower(global.senha) == "batatadoce" then
				table.insert(screenmanager.screens["level1"].powerups,powerup:new({x=self.x,y=self.y,type="firesword"}))
				screenmanager.screens["level1"].player.firesword = true
			end
		end
	end
end

function chest:draw()
	love.graphics.draw(self.image,self.anim[self.actualAnim][self.frame],self.x,self.y,self.angle,self.xscale,self.yscale,self.xorigin,self.yorigin)

	if self.open and (self.type == "batata" or self.type == "doce") then
		love.graphics.draw(self.insideimage[self.type],self.x,self.y-16+(math.sin(self.dy) * 0.2),self.angle,1,1,16,8)
	end

end