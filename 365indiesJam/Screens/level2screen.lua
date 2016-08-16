level2=gamescreen:new()
level1.background={
	image = nil,
	quad = nil,
	x=0,
	y=0,
	dx=0,
	dy=0
}

function level2:load()

	self.map = map:new()
	self.objects={}

	self.map:loadMap("Assets/level2.lua")
	self.background.image = love.graphics.newImage("Assets/bg_sky.png")
	self.background.image:setFilter("nearest","nearest")
	self.background.image:setWrap("repeat","repeat")
	self.background.dx=-0.2

	table.insert(self.objects,player:new())
	local dol = dolphin:new()
	--table.insert(self.objects,dol)
	self:getObjects()
	self.background.quad = love.graphics.newQuad(0,0,self.map.test.width*16, self.map.test.height*16, self.background.image:getDimensions())
end

function level2:update(dt)
	for i,v in ipairs(self.objects) do
		v:update(dt)
		for j,ob in ipairs(level1.objects) do
			print(utils.collision(v,ob))
		end
	end
	self.oldCamX = camera.x
	camera.x = -self.objects[1].x+64
	camera.y = -self.objects[1].y+64

	utils.cameraBound()
	self.background.x = self.background.x + (self.background.dx*-utils.sign(camera.x - self.oldCamX))
	self.background.y = self.background.y + self.background.dy
	--player:update(dt)
	--dol:update(dt)
end

function level2:draw()
	love.graphics.draw(self.background.image, self.background.quad,self.background.x,self.background.y)
	love.graphics.translate(camera.x, camera.y)
	self.map:draw()
	for i,v in ipairs(self.objects) do
		v:draw()
	end
	--player:draw()
	--dol:draw()
end