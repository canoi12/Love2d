player = gameobject:new{}


function player:new(o)
	o = o or {}
	self:load()
	return setmetatable(o, {__index=self})
end

function player:load()
	self.image = love.graphics.newImage("Assets/warrior.png")
	self.image:setFilter("nearest","nearest")
	self.kind=1

	self.x = 50
	self.y = 50
	self.friction = 0.8

	self:addAnim("idle",0,0,16,16,3)
	self:addAnim("walk",0,16,16,16,6)
end

function player:move()
	local keyLeft = love.keyboard.isDown("left")
	local keyRight = love.keyboard.isDown("right")
	local keyUp = love.keyboard.isDown("up")

	local xprevious = self.x
	local yprevious = self.y

	if keyLeft then
		self.dx = -1.2
	elseif keyRight then
		self.dx = 1.2
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
	if not utils.check_solid(self.x, self.y-10+16) then
		self.dy = self.dy + self.gravity
	else
		--while map.tmap[math.floor(((self.y-9)/16))+1][math.floor((self.x)/16)] == gamescreen.map.test.tilesets[1].tiles[1].id+1 do
		while utils.check_solid(self.x,self.y-11+16) do
			self.y = self.y-1
		end
		self.dy = self.dy * -self.bounce
		if keyUp then
			self.dy = -3.1
		end
	end

	self.x = self.x + self.dx
	self.y = self.y + self.dy

	if utils.check_solid(self.x-16+13,self.y) or utils.check_solid(self.x+16-13,self.y) then
		self.dx = 0
		while utils.check_solid(self.x-16+13,self.y) do
			self.x = self.x + 1
		end
		while utils.check_solid(self.x+16-13,self.y) do
			self.x = self.x - 1
		end
	end

end

function player:bounds()
	self.x = math.max(self.xorigin,math.min(self.x, (screenmanager.currentScreen.map.test.width*16)-self.xorigin))

end

function player:update(dt)

	self:playAnim()

	self:move()

	self:bounds()	
end

function player:draw()
	love.graphics.draw(self.image, player.anim[self.actualAnim][self.frame],self.x, self.y, 0, self.flip*self.xscale, self.yscale, self.xorigin, self.yorigin)
end