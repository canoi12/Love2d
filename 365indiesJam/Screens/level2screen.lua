level2=gamescreen:new()

function level2:load()

	self.map = map:new()
	self.objects={}

	self.map:loadMap("Assets/level2.lua")
	self.bg_image = love.graphics.newImage("Assets/bg_sky.png")
	self.bg_image:setFilter("nearest","nearest")
	self.bg_image:setWrap("repeat","repeat")

	table.insert(self.objects,player:new())
	local dol = dolphin:new()
	table.insert(self.objects,dol)
	self.bg_quad = love.graphics.newQuad(0,0,self.map.test.width*16, self.map.test.height*16, self.bg_image:getDimensions())
end

function level2:update(dt)
	camera.x = -self.objects[1].x+64
	camera.y = -self.objects[1].y+64
	for i,v in ipairs(self.objects) do
		v:update(dt)
	end
	--player:update(dt)
	--dol:update(dt)
end

function level2:draw()
	love.graphics.draw(self.bg_image,self.bg_quad,0,0)
	self.map:draw()
	for i,v in ipairs(self.objects) do
		v:draw()
	end
	--player:draw()
	--dol:draw()
end