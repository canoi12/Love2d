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
	self.pause = false
	self.transition = false

	local quadrantNumber = 0

	quadrantNumber = ((self.map.test.width*self.tilewidth)/global.width)*((self.map.test.height*self.tileheight)/global.height)

	for i=0,quadrantNumber-1 do
		self.quadrants[i] = {}
	end

	self.player = player:new()
	--[[self.player.x = 568
	self.player.y = 88]]

	table.insert(self.objects,self.player)
	self.objects[1].x = 568
	self.objects[1].y = 88
	self.activeSpawn.x = 568
	self.activeSpawn.y = 88
	--local dol = dolphin:new()
	--table.insert(self.objects,dol)
	self:getObjects()
	self:getSpawns()
	self:getPowerUps()
	print(self.powerups[1].type)
	self.background.quad = love.graphics.newQuad(0,0,self.map.test.width*(self.map.test.tilewidth), self.map.test.height*self.map.test.tileheight, self.background.image:getDimensions())
end

function level1:resetEnemies()
	for j=2,table.getn(self.objects) do
		table.remove(self.objects,2)
	end
	--print(table.getn(self.objects))
	self:getObjects()
end

function level1:reset()
	for i, v in ipairs(self.objects) do
		v = nil
	end
	self:load()
end

function level1:update(dt)
	--player:update(dt)
	if not self.pause and not self.transition then
		for i,v in ipairs(self.objects) do
			if (v.quadrant == self.activequadrant or v.kind == 1) then
				v:update(dt)
				if v.destroy then
					table.remove(self.objects, i)
				end
			end
		end
		for i,v in ipairs(self.spawns) do
			v:update(dt)
		end
		for i,v in ipairs(self.powerups) do
			v:update(dt)
			if v.destroy then
				table.remove(self.objects, i)
			end
		end
	end
	if self.transition then
		transition:update()
	end
	if self.dialogue then
		textbox:update(dt)
	end
	--[[camera.x = -self.objects[1].x+(global.width/2)
	camera.y = -self.objects[1].y+(global.height/2)]]

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
	--player:draw()
	for i,v in ipairs(self.spawns) do
		v:draw()
	end
	for i,v in ipairs(self.objects) do
		v:draw()
	end
	for i,v in ipairs(self.powerups) do
		v:draw()
	end
	if self.transition then
		transition:draw()
	end
	if self.dialogue then
		textbox:draw()
	end
	for i,v in ipairs(self.spawns) do
		if v.message then
			love.graphics.setColor(0,0,0,125)
			love.graphics.rectangle("fill",math.abs(camera.x),32+math.abs(camera.y),global.width,8)
			love.graphics.setColor(255,255,255,255)
			love.graphics.print("Game Saved", 40+math.abs(camera.x),28+math.abs(camera.y))
		end
	end
	--player:draw()
	--dol:draw()
end

function level1:keypressed(key)
	player:keypressed(key)
	for i,v in ipairs(level1.objects) do
		v:keypressed(key)
	end
	if key == "x" and self.dialogue then
		textbox:next()
	end
end