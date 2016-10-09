go = require "gameobject"
local player = go:new({anim={},   image = love.graphics.newImage("assets/image/Protagonist.png"),  currentAnimation = "idle"})

local oldKeyUp = false

--[[function player:collision(obj2)
	if self == obj2 then
		return false
	end



	local ob1 = {
		x = self.bbox.left + self.x - self.xorigin,
		y = self.bbox.top + self.y - self.yorigin,
		w = self.bbox.right,
		h = self.bbox.bottom
	}

	ob1.xc = (ob1.x) + (ob1.w/2)
	ob1.yc = ob1.y + (ob1.h/2)

	local ob2 = {
		x = obj2.bbox.left + obj2.x,
		y = obj2.bbox.top + obj2.y,
		w = obj2.bbox.right,
		h = obj2.bbox.bottom
	}

	ob2.xc = (ob2.x) + (ob2.w/2)
	ob2.yc = ob2.y + (ob2.h/2)

	local w = (ob1.w + ob2.w)/2
	local h = (ob1.h + ob2.h)/2

	local dx = ob1.xc - ob2.xc
	local dy = ob1.yc - ob2.yc

	if math.abs(dx) <= w and math.abs(dy) <= h then
		local wy = w * dy
		local hx = h * dx

		if wy > hx then
			if wy > -hx then
				self.y = obj2.y + obj2.bbox.bottom + self.yorigin
			else
				self.x = obj2.x + obj2.bbox.right + self.xorigin
			end
		else
			if wy > -hx then
				self.x = obj2.x - self.xorigin
			else
				self.y = obj2.y - self.yorigin
				self.isGround = true
			end
		end
		return true
	end
	return false

end]]

function player:collision(obj2)
	if self == obj2 then
		return false
	end

	local dx = (((self.x - self.xorigin)+(self.width/2))) - (obj2.x + (obj2.width/2))
	local dy = (((self.y - self.yorigin)+(self.height/2))) - (obj2.y + (obj2.height/2))

	local w = (self.width + obj2.width)/2
	local h = (self.height + obj2.height)/2

	if math.abs(dx) <= w and math.abs(dy) <= h then

		if (self.y - self.yorigin) > (obj2.y + obj2.height) - 1 - math.abs(self.dy) then
			self.y = obj2.y + obj2.height + self.yorigin
		elseif ((self.y - self.yorigin) + self.height) < obj2.y + 1 +math.abs(self.dy) then
			self.y = obj2.y - self.yorigin
			self.isGround = true
		elseif ((self.x - self.xorigin) < (obj2.x + obj2.width) - 1 - math.abs(self.dx)) then
			self.x = obj2.x + obj2.width + self.xorigin
		elseif ((self.x - self.xorigin) + self.width) > obj2.x + 1 + math.abs(self.dx) then
			self.x = obj2.x - self.xorigin
		end

		return true
	end
	return false
end

function player:new(o)
  o = o or {}
  self:init()
  return setmetatable(o, {__index=self})
end

function player:init()
  self.anim["idle"] = self:newAnim(0,0,16,16,player.image:getDimensions())
  self.anim["walk"] = self:newAnim(16,4,16,16,player.image:getDimensions())
	self.anim["fly"] = self:newAnim(32,0,16,16,player.image:getDimensions())
	self.image:setFilter("nearest","nearest")
end

function player:fgravity()
	local keyUp = love.keyboard.isDown("up") or love.keyboard.isDown("x")
	local keyFly = love.keyboard.isDown("x") or love.keyboard.isDown("up")
	if not( utils.check_solid(self.x + math.abs(self.dx), self.y+8) or utils.check_solid(self.x - math.abs(self.dx), self.y+8)) then
		self.dy = self.dy + self.gravity
		self.isGround = false
	else
		--while map.tmap[math.floor(((self.y-9)/16))+1][math.floor((self.x)/16)] == gamescreen.map.test.tilesets[1].tiles[1].id+1 do
		if not self.isGround then
			self.isGround = true
			self.xscale = 1.8
			self.yscale = 0.4
		end

		--[[if not firstDialogue then
			textbox:createDialogue(1,16)
			self.xscale = 1
			self.yscale = 1
			firstDialogue = true
		end]]

		while utils.check_solid(self.x + math.abs(self.dx), self.y+7) or utils.check_solid(self.x - math.abs(self.dx), self.y+7) do
			self.y = self.y-1
		end
		self.dy = self.dy * -self.bounce
	end

	if keyUp and not(oldKeyUp) and self.isGround then
		self.dy = -0.8
		self.xscale=0.4
		self.yscale=1.8
	end

	if keyFly and not self.isGround then
		if self.dy > -2 then
			self.dy = self.dy - 0.12
		end
	end

	oldKeyUp = keyUp
end

function player:move()
	local keyLeft = love.keyboard.isDown("left")
	local keyRight = love.keyboard.isDown("right")


	local xprevious = self.x
	local yprevious = self.y

	if keyLeft then
		self.dx = -1.4
	elseif keyRight then
		self.dx = 1.4
	end

	if not(keyLeft or keyRight) and self.isGround then
		self.dx = self.dx * self.friction
		self:setAnimation("idle")
	elseif (keyLeft or keyRight) and self.isGround then
		self.flip = utils.sign(self.dx)
		self:setAnimation("walk")
	elseif not self.isGround then
		if (keyLeft or keyRight) then
			self.flip = utils.sign(self.dx)
		else
			self.dx = self.dx * self.friction
		end
		self:setAnimation("fly")
	end
	--if self.y < 127-self.xorigin then
	--if gamescreen.map.tmap[math.floor(((self.y-8)/16))+1][math.floor((self.x)/16)] ~= gamescreen.map.test.tilesets[1].tiles[1].id+1 then


	if utils.check_solid(self.x, self.y - 6) then
		self.dy = 0
		self.y = self.y + 1
	end

	if utils.check_solid(self.x-5+self.dx,self.y) or utils.check_solid(self.x+5+self.dx,self.y) then
		self.dx = 0
		while utils.check_solid(self.x-5,self.y) do
			self.x = self.x  + 1.0 --(+1.2)
		end
		while utils.check_solid(self.x+5,self.y) do
			self.x = self.x - 1.0 --1.2
		end
	end

	self.x = self.x + self.dx
	self.y = self.y + self.dy

	self.xscale = utils.approach(self.xscale,1.0,0.1)
	self.yscale = utils.approach(self.yscale,1.0,0.1)

	--[[if utils.check_trap(self.x, self.y+8) then
		transition:doTransition(0.4)
	end]]
end

function player:bounds()
	self.x = math.max(self.xorigin,math.min(self.x, (screenmanager.currentScreen.map.test.width*screenmanager.currentScreen.tilewidth)-self.xorigin))
	self.y = math.max(self.yorigin,math.min(self.y, (screenmanager.currentScreen.map.test.height*screenmanager.currentScreen.tileheight)-self.yorigin))
end

function player:update(dt)
  --[[self:playAnim(self.currentAnimation)
  if love.keyboard.isDown("left") then
    self.x = self.x - 2
  end
  if love.keyboard.isDown("right") then
    self.x = self.x + 2
  end

  if self.y < (144-32) then
    self.y = self.y + 2
  end]]
	--[[for i,chao in ipairs(screenmanager.currentScreen.chao) do
		self.collision(self, chao)
	end]]

  self:playAnim()
  self:fgravity()
  self:move()
  self:bounds()

	global.camerax = math.max(0, math.min(self.x - 80, screenmanager.currentScreen.map.test.width*16 - 160))
	global.cameray = math.max(0, math.min(self.y - 72, screenmanager.currentScreen.map.test.height*16 - 144))
end

function player:draw()
	--love.graphics.rectangle("line", self.bbox.left + self.x - self.xorigin, self.bbox.top + self.y - self.yorigin, self.bbox.right, self.bbox.bottom)
  love.graphics.draw(self.image,self.anim[self.currentAnimation][self.currentFrame],self.x, self.y, self.angle, self.flip*self.xscale, self.yscale, self.xorigin, self.yorigin)
end

return player
