level1=gamescreen:new()

function level1:load()
	self.map = map:new()
	self.objects={}

	print(self.objects)

	self.map:loadMap("Assets/level1.lua")
	self.bg_image = love.graphics.newImage("Assets/bg_fix.png")
	self.bg_image:setFilter("nearest","nearest")
	self.bg_image:setWrap("repeat","repeat")

	table.insert(self.objects,player:new())
	local dol = dolphin:new()
	table.insert(self.objects,dol)
	self.bg_quad = love.graphics.newQuad(0,0,self.map.test.width*16, self.map.test.height*16, self.bg_image:getDimensions())
end

function level1:reset()

end

function level1:update(dt)
	camera.x = -self.objects[1].x+64
	camera.y = -self.objects[1].y+64
	for i,v in ipairs(level1.objects) do
		v:update(dt)
	end
	if love.keyboard.isDown("z") then
		screenmanager:setScreen("level2")
	end
	--player:update(dt)
	--dol:update(dt)
end

function level1:draw()
	love.graphics.draw(self.bg_image,self.bg_quad,0,0)
	self.map:draw()
	for i,v in ipairs(self.objects) do
		v:draw()
	end
	--player:draw()
	--dol:draw()
end