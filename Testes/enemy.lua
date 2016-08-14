enemy=gameobject:new()

enemy.image = love.graphics.newImage("dolphin-idle.png")

function enemy:load()
	print(self.teste)
	self:addAnim("idle",0,0,16,16,4)
end

function enemy:update(dt)
	enemy:playAnim()
	print("enemy",self.frame)
	if self.y < 480 then
		self.dy = self.dy + self.grav
	else
		self.dy = 0
		self.y = 480
	end

	self.y = self.y + self.dy
end

function enemy:draw()
	love.graphics.draw(self.image,self.anim[self.actualAnim][self.frame],self.x, self.y)
end