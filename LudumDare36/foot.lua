foot = gameobject:new()

foot.x = 0
foot.y = 0
foot.destroy = true
foot.color = {52,54,53,255}
foot.image = love.graphics.newImage("assets/foot.png")
foot.image:setFilter("nearest","nearest")

function foot:load()
	self.erase = 40
end

function foot:update(dt)
	if self.erase > 0 and self.destroy then
		self.erase = self.erase - 0.1
	end
end

function foot:draw()
	love.graphics.setColor(self.color)
	love.graphics.draw(self.image,math.floor(self.x),math.floor(self.y+8))
	love.graphics.setColor(255,255,255,255)
end