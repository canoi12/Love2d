level1=gamescreen:new()
level1.background={
	image = nil,
	quad = nil,
	x=0,
	y=0,
	dx=0,
	dy=0
}

function level1:load()
	self.map = map:new()
	self.objects={}

	self.map:loadMap("Assets/testemenor.lua")
	self.background.image = love.graphics.newImage("Assets/bg_fix.png")
	self.background.image:setFilter("nearest","nearest")
	self.background.image:setWrap("clampzero","repeat")
	self.background.dx=-0.2
	self.tilewidth = self.map.test.tilewidth
	self.tileheight = self.map.test.tileheight

	table.insert(self.objects,player:new())
	--self.objects[1].x = 768
	--self.objects[1].y = 704
	--local dol = dolphin:new()
	--table.insert(self.objects,dol)
	self:getObjects()
	self.background.quad = love.graphics.newQuad(0,0,self.map.test.width*(self.map.test.tilewidth), self.map.test.height*self.map.test.tileheight, self.background.image:getDimensions())
end

function level1:reset()
	for i, v in ipairs(self.objects) do
		v = nil
	end
	self:load()
end

function level1:update(dt)
	for i,v in ipairs(self.objects) do
		if (v.x >= math.abs(camera.x)-5 and v.x <= math.abs(camera.x-global.width)+5 and
		   v.y >= math.abs(camera.y)-5 and v.y <= math.abs(camera.y-global.height)+5) or v.kind == 1 then
			v:update(dt)
			for j,ob in ipairs(self.objects) do
				v:collision(ob)
			end
			if v.destroy then
				table.remove(self.objects, i)
			end
		end
	end
	self.oldCamX = camera.x
	camera.x = -self.objects[1].x+(global.width/2)
	camera.y = -self.objects[1].y+(global.height/2)

	utils.cameraBound()
	self.background.x = self.background.x+(self.background.dx)
	self.background.y = self.background.y + self.background.dy
	if self.background.x <= -global.width then
		self.background.x = 0
	end

	if love.keyboard.isDown("r") then
		self:reset()
	end
	--player:update(dt)
	--dol:update(dt)
end

function level1:draw()
	love.graphics.draw(self.background.image, self.background.quad,self.background.x,self.background.y)
	love.graphics.draw(self.background.image, self.background.quad,self.background.x+128,self.background.y)
	love.graphics.translate(camera.x, camera.y)
	self.map:draw()
	for i,v in ipairs(self.objects) do
		v:draw()
	end
	--player:draw()
	--dol:draw()
end

function level1:keypressed(key)
	for i,v in ipairs(level1.objects) do
		v:keypressed(key)
	end
end