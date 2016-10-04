go = require "gameobject"
local player = go:new({anim={},   image = love.graphics.newImage("assets/image/Protagonist.png"),  currentAnimation = "idle"})

local oldKeyUp = false

function player:new(o)
  o = o or {}
  self:init()
  return setmetatable(o, {__index=self})
end

function player:init()
  self.anim["idle"] = self:newAnim(0,0,16,16,player.image:getDimensions())
  self.anim["walk"] = self:newAnim(16,4,16,16,player.image:getDimensions())
end

function player:fgravity()
	local keyUp = love.keyboard.isDown("up")
	if not( utils.check_solid(self.x + math.abs(self.dx), self.y+6) or utils.check_solid(self.x - math.abs(self.dx), self.y+6)) then
		self.dy = self.dy + self.gravity
		self.isGround = false
	else
		--while map.tmap[math.floor(((self.y-9)/16))+1][math.floor((self.x)/16)] == gamescreen.map.test.tilesets[1].tiles[1].id+1 do
		if not self.isGround then
			self.isGround = true
			self.xscale = 1.6
			self.yscale = 0.6
		end

		--[[if not firstDialogue then
			textbox:createDialogue(1,16)
			self.xscale = 1
			self.yscale = 1
			firstDialogue = true
		end]]
		while utils.check_solid(self.x + math.abs(self.dx), self.y+5) or utils.check_solid(self.x - math.abs(self.dx), self.y+5) do
			self.y = self.y-1
		end
		self.dy = self.dy * -self.bounce
	end
	if keyUp and not(oldKeyUp) and self.isGround then
		self.dy = -3.2
		self.xscale=0.4
		self.yscale=1.8
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

	if not(keyLeft or keyRight) then
		self.dx = self.dx * self.friction
		self:setAnimation("idle")
	else
		self.flip = utils.sign(self.dx)
		self:setAnimation("walk")
	end
	--if self.y < 127-self.xorigin then
	--if gamescreen.map.tmap[math.floor(((self.y-8)/16))+1][math.floor((self.x)/16)] ~= gamescreen.map.test.tilesets[1].tiles[1].id+1 then


	if utils.check_solid(self.x, self.y - 6) then
		self.dy = 0
		self.y = self.y + 1
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
  self:playAnim()
  self:fgravity()
  self:move()
  self:bounds()
end

function player:draw()
  love.graphics.draw(self.image,self.anim[self.currentAnimation][self.currentFrame],self.x, self.y, self.angle, self.flip*self.xscale, self.yscale, self.xorigin, self.yorigin)
end

return player
