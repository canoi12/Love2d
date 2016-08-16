player=gameobject:new()


player.image = love.graphics.newImage("warrior-idle.png")
player.grav = 0.4

function player:load()
	print(self.teste)
	player:addAnim("idle",0,0,16,16,3)
end

function player:update(dt)
	self:playAnim()
	print("player",self.frame)
	if self.y < 480 then
		self.dy = self.dy + self.grav
	else
		self.dy = 0
		self.y = 480
	end

	if love.keyboard.isDown("left") then
		self:move(-2)
	elseif love.keyboard.isDown("right") then
		self:move(2)
	end

	self.y = self.y + self.dy
	self.x = self.x + self.dx
end

function player:draw()
	love.graphics.draw(self.image,self.anim[self.actualAnim][self.frame],self.x, self.y)
end