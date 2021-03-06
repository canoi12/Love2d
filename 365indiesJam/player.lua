player = gameobject:new{}
player.sword={}
player.bbox = {
	left = 0,
	right = 16,
	top = 0,
	bottom = 16
}

firstDialogue = false;
local oldKeyDash = false

player.firesword = false

function player:new(o)
	o = o or {}
	self:load()
	return setmetatable(o, {__index=self})
end

function player:collision(obj2)
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

		if obj2.kind == 3 or obj2.kind == 5 then
			if obj2.type == "doublejump" then
				self.candoublejump = true
				if not obj2.destroy then
					obj2:showMessage()
				end
 				obj2.destroy = true
			elseif obj2.type == "dash" then
				self.candash = true
				if not obj2.destroy then
					obj2:showMessage()
				end
 				obj2.destroy = true
 			elseif obj2.type == "firesword" then
 				self.firesword= true
				if not obj2.destroy then
					obj2:showMessage()
				end
 				obj2.destroy = true
			end
			return true
		end

		if obj2.kind == 6 and not obj2.destroy then
			transition:doTransition(0.4)
			return true
		end

		if obj2.kind == 4 then
			--self:backToSpawn()
			transition:doTransition(0.4)
			obj2.destroy = true
			return true
		elseif obj2.type=="dolphin" then
			transition:doTransition(0.4)
			obj2.destroy = true
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

function player:load()
	self.image = love.graphics.newImage("Assets/warrior2.png")
	self.image:setFilter("nearest","nearest")
	self.kind=1
	self.type = "player"
	self.bbox = {
		left = 4,
		right = 12,
		top = 2,
		bottom = 16
	}

	self.x = 50
	self.y = 50
	self.friction = 0.2
	self.candoublejump = false
	self.candash = false
	self.jumpcount = 0
	self.ondash = false
	self.dashTime = 0
	self.dashDir = 0

	self.dashCount = 0

	self.jumpSound = love.audio.newSource("Assets/sounds/Jump.wav","static")
	self.jumpSound:setVolume(0.4)

	self.dashSound = love.audio.newSource("Assets/sounds/Dash.wav","static")
	self.dashSound:setVolume(0.5)

	self:addAnim("idle",0,0,16,16,3)
	self:addAnim("walk",0,16,16,16,6)
	oldKeyUp = false

	self.sword = sword:new()
end

function player:fgravity()
	local keyUp = love.keyboard.isDown("up") or (Joystick[1]:isDown(1))
	if not( utils.check_solid(self.x + math.abs(self.dx), self.y+6) or utils.check_solid(self.x - math.abs(self.dx), self.y+6)) and not((utils.check_through(self.x + 2, self.y+8) or utils.check_through(self.x - 2, self.y+8)) and self.dy >= 0) then
		self.dy = self.dy + self.gravity
		self.isGround = false
		if self.jumpcount == 0 and self.candoublejump then
			self.jumpcount = 1
		elseif self.jumpcount == 0 or self.jumpcount == 1 and not self.candoublejump then
			self.jumpcount = 2
		end
	else
		--while map.tmap[math.floor(((self.y-9)/16))+1][math.floor((self.x)/16)] == gamescreen.map.test.tilesets[1].tiles[1].id+1 do
		if not self.isGround then
			self.isGround = true
			self.xscale = 1.6
			self.yscale = 0.6
		end
		self.dashCount = 0
		self.jumpcount = 0
		if not firstDialogue then
			textbox:createDialogue(1,16)
			self.xscale = 1
			self.yscale = 1
			firstDialogue = true
		end
		while utils.check_solid(self.x + math.abs(self.dx), self.y+5) or utils.check_solid(self.x - math.abs(self.dx), self.y+5) do
			self.y = self.y-1
		end
		while utils.check_through(self.x + math.abs(self.dx), self.y+7) or utils.check_through(self.x - math.abs(self.dx), self.y+7) do
			self.y = self.y - 1
		end
		self.dy = self.dy * -self.bounce
	end
	if keyUp and not(oldKeyUp) and (self.jumpcount < 2) then
		self.dy = -3.2
		self.xscale=0.4
		self.yscale=1.8
		self.jumpcount = self.jumpcount + 1
		self.jumpSound:play()
	end
	oldKeyUp = keyUp
end

function player:move()
	local keyLeft = love.keyboard.isDown("left") or (Joystick[1]:getAxis(1) < -0.4)
	local keyRight = love.keyboard.isDown("right") or (Joystick[1]:getAxis(1) > 0.4)
	local keyDash = love.keyboard.isDown("x") or (Joystick[1]:getAxis(3) > 0) or (Joystick[1]:getAxis(6) > 0)
	

	local xprevious = self.x
	local yprevious = self.y

	if keyLeft then
		self.dx = -1.4
	elseif keyRight then
		self.dx = 1.4
	end

	if not(keyLeft or keyRight) then 
		self.dx = self.dx * self.friction
		self:setAnim("idle")
	else
		self.flip = utils.sign(self.dx)
		self:setAnim("walk")
	end
	--if self.y < 127-self.xorigin then
	--if gamescreen.map.tmap[math.floor(((self.y-8)/16))+1][math.floor((self.x)/16)] ~= gamescreen.map.test.tilesets[1].tiles[1].id+1 then
	if not self.ondash then	
		self:fgravity()
	end
	

	if utils.check_solid(self.x, self.y - 6) then
		self.dy = 0
		self.y = self.y + 1
	end

	if self.candash then
		--print()
		if keyDash and not oldKeyDash and not self.ondash and self.dashCount == 0 then
			self.ondash = true
			self.dashTime = 2
			self.dy = 0
			self.dashSound:play()
			self.dashCount = 1
			--if self
			--print("can dash")
		end
		if self.ondash then
			self.dx = 3 * self.flip
		end

		if self.dashTime > 0 then
			self.dashTime = self.dashTime - 0.2
		else
			self.ondash = false
		end
	end

	if utils.check_solid(self.x-3+self.dx,self.y) or utils.check_solid(self.x+3+self.dx,self.y) then
		self.dx = 0
		while utils.check_solid(self.x-3,self.y) do
			self.x = self.x  + 1.2 --(+1.2)
		end
		while utils.check_solid(self.x+3,self.y) do
			self.x = self.x - 1.2 --1.2
		end
	end
	oldKeyDash = keyDash

	self.sword.x = self.x
	self.sword.y = self.y
	self.sword.flip = self.flip

	self.sword:update(dt)

	self.x = self.x + self.dx
	self.y = self.y + self.dy

	self.xscale = utils.approach(self.xscale,1.0,0.1)
	self.yscale = utils.approach(self.yscale,1.0,0.1)

	if utils.check_trap(self.x, self.y+8) then
		transition:doTransition(0.4)
	end

	--print(self.xscale, self.yscale)
end

function player:backToSpawn()
	self.x = screenmanager.currentScreen.activeSpawn.x
	self.y = screenmanager.currentScreen.activeSpawn.y
	self.sword.x = self.x
	self.sword.y = self.y
	self.sword.flip = self.flip
end

function player:bounds()
	self.x = math.max(self.xorigin,math.min(self.x, (screenmanager.currentScreen.map.test.width*screenmanager.currentScreen.tilewidth)-self.xorigin))
	self.y = math.max(self.yorigin,math.min(self.y, (screenmanager.currentScreen.map.test.height*screenmanager.currentScreen.tileheight)-self.yorigin))
end

function player:update(dt)
	local keyDown = love.keyboard.isDown("down") or (Joystick[1]:getAxis(2) > 0.4)

	self:playAnim()

	if not screenmanager.currentScreen.dialogue and not global.finalFinalCutscene then

		self:move()
		for i,v in ipairs(screenmanager.currentScreen.objects) do
			self:collision(v)
		end
		for i,v in ipairs(screenmanager.currentScreen.spawns) do
			if self:collision(v) and keyDown then
				if v ~= screenmanager.currentScreen.activeSpawn then
					v:showMessage()
				end
				screenmanager.currentScreen.activeSpawn = v
				global:save()
			elseif self:collision(v) then
				v.showKey = true
			else
				v.showKey = false
			end
		end
		for i,v in ipairs(screenmanager.currentScreen.powerups) do
			--print(v)
			self:collision(v)
		end
		if not screenmanager.screens["level1"].boss.destroy then
			self:collision(screenmanager.currentScreen.boss)
			for i,v in ipairs(screenmanager.currentScreen.boss.minions) do
				self:collision(v)
			end
		end
	end	
	self.sword.firesword = self.firesword
	self:bounds()
end

function player:draw()
	love.graphics.draw(self.image, player.anim[self.actualAnim][self.frame],self.x, self.y, self.angle, self.flip*self.xscale, self.yscale, self.xorigin, self.yorigin)
	--love.graphics.rectangle("line",self.x+self.bbox.left-self.xorigin,self.y+self.bbox.top-self.yorigin, self.bbox.right-self.bbox.left,self.bbox.bottom-self.bbox.top)
	self.sword:draw()
end

function player:keypressed(key)
	
end