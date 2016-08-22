boss=gameobject:new{anim={}}

boss.shootCount = 15
boss.shootTime = 2
boss.state = nil

boss.minionsCount = 2
boss.minions = {}
boss.minionsSpawn = true
boss.spawnTime = 5

boss.restTime = 30

function boss:new(o)
	o = o or {}
	o.quadrant = math.floor(o.x/global.width) + (math.floor(o.y/global.height)*(level1.map.test.width*level1.tilewidth)/global.width)
	self:load()
	return setmetatable(o, {__index=self})
end

function boss:collision(obj2)
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

function shootState(self)
	if self.shootTime > 0 then
		self.shootTime = self.shootTime - 0.2
	else
		if self.shootCount > 0 then
			table.insert(screenmanager.currentScreen.objects, shit:new({x=self.x,y=self.y-8,dx=love.math.random(2),dy=-love.math.random(4),quadrant=self.quadrant,angle=math.rad(love.math.random(90))}))
			self.shootCount = self.shootCount - 1
			self.shootTime = 2
		else
			self.minionsSpawn = true
			self:playAnim("summon")
			self.state = summonState
		end
	end
end

function summonState(self)
	if self.spawnTime > 0 then
		self.spawnTime = self.spawnTime - 0.2
	end
	if table.getn(self.minions) < self.minionsCount and self.minionsSpawn  and self.spawnTime <= 0 then
		table.insert(self.minions, dolphin:new({x=self.x,y=self.y}))
		self.spawnTime = 5
	elseif table.getn(self.minions) >= self.minionsCount then
		self.minionsSpawn = false
	end

	if not self.minionsSpawn then
		if table.getn(self.minions) <= 0 then
			self.restTime = 30
			self:playAnim("idle")
			self.state = restState
		end
	end
end

function restState(self)
	if self.restTime > 0 then
		self.restTime = self.restTime - 0.1
	else
		self.shootTime = 2
		self.shootCount = 15
		self.state = shootState
	end
end

function boss:load()
	self.image = love.graphics.newImage("Assets/boss.png")
	self.x = 1424
	self.y = 600

	self:addAnim("idle",0,32,16,16,2)
	self:addAnim("attack",0,0,16,16,4)
	self:addAnim("summon",0,16,16,16,1)
	self.dx = 0
	self.bounce = 0.2
	self.flip = -1
	self.animSpeed=0.25
	self.life = 30
	self.kind = 6
	self.image:setFilter("nearest","nearest")
	self.type = "boss"

	self.damageSound = love.audio.newSource("Assets/sounds/Hit_Hurt.wav","static")
	self.damageSound:setVolume(0.5)

	self.shootCount = 5
	self.shootTime = 3
	self.state = shootState

	self.bbox = {
		left = 1,
		right = 12,
		top = 2,
		bottom = 16
	}
	self:playAnim("attack")
end

function boss:move()
	if not utils.check_solid(self.x, self.y+7) then
		self.dy = self.dy + self.gravity
	else
		--while map.tmap[math.floor(((self.y-9)/16))+1][math.floor((self.x)/16)] == gamescreen.map.test.tilesets[1].tiles[1].id+1 do
		while utils.check_solid(self.x,self.y+6) do
			self.y = self.y-1
		end
		self.dy = self.dy * -self.bounce
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
		if screenmanager.currentScreen.player.sword.attack and not self.damage and self.state == restState then
			self.damage = true
			self.damageTime = 1
			if not screenmanager.currentScreen.player.sword.firesword then
				self.life = self.life - 1
			else
				self.life = self.life - 2
			end
			self.dy = -2
			self.dx = screenmanager.currentScreen.player.sword.flip * 1.2
			self.damageSound:play()
		end
	end

	if self.life <= 0 then
		self.destroy = true
		if not global.finalBossDialogue then
			textbox:createDialogue(21,23)
			global.finalBossDialogue = true
			screenmanager.screens["level1"].player.flip = 1
			screenmanager.screens["level1"].player.sword.flip = 1
			screenmanager.screens["level1"].player.sword.angle = 0
		end
	end
	-- End damage taken
	self.y = self.y + self.dy
end

function boss:update(dt)
	self:playAnim()
	self:move()
	self:state()
	for i,v in ipairs(self.minions) do
		v:update(dt)
		if v.destroy then
			table.remove(self.minions,i)
		end
	end
end

function boss:draw()
	if self.damage then
		love.graphics.setColor(255,255,255,math.sin(self.damageTime) * 255)
	else
		love.graphics.setColor(255,255,255,255)
	end
	love.graphics.draw(self.image,self.anim[self.actualAnim][self.frame],self.x,self.y,self.angle,self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin)
	--love.graphics.circle("fill",self.x,self.y,1000)
	love.graphics.setColor(255,255,255,255)
	for i,v in ipairs(self.minions) do
		v:draw()
	end
	love.graphics.setColor(255,0,77,255)
	love.graphics.rectangle("fill",16+math.abs(camera.x),math.abs(camera.y)+global.height-12,(self.life/30)*100,8)
	love.graphics.setColor(255,255,255,255)
	--love.graphics.print(self.life,self.x,self.y)
	--love.graphics.print(self.quadrant, self.x, self.y)
	--love.graphics.rectangle("line",self.x+self.bbox.left-self.xorigin,self.y+self.bbox.top-self.yorigin, self.bbox.right,self.bbox.bottom)
end