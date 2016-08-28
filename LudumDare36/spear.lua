spear=gameobject:new()

function spear:load()

	self.image = love.graphics.newImage("assets/spear.png")

	self.image:setFilter("nearest","nearest")

	self.xorigin = self.image:getWidth()/2
	self.yorigin = self.image:getHeight()/2

	self.sin = 0

	self.attack = false
	self.attackMove = 0
end

function spear:update(dt)

	if love.keyboard.isDown("z") then
		self.attack = true
	end

	self.sin = self.sin + 0.2

	if self.sin % math.pi*2 == 0 then
		self.sin = 0
	end

	if self.attack then
		self.attackMove = self.attackMove + 0.4

		print(self.attackMove % math.pi*2)

		if self.attackMove % math.pi*2 <= 0.6 then
			self.attackMove = 0
			self.attack = false
		end
	end
end

function spear:draw()
	if player.actualAnim == "walk" then
		love.graphics.draw(self.image,self.x+math.sin(self.flip*self.attackMove)*6+(6*self.flip),self.y+math.sin(self.sin),self.angle,self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin)
	else
		love.graphics.draw(self.image,self.x+math.sin(self.flip*self.attackMove)*6+(6*self.flip),self.y,self.angle,self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin)
	end
end