menu=gamescreen:new()
menu.options = {
	[1] = "New game",
	[2] = "Credits",
	[3] = "Exit"
}

menu.curoption = 1

k = 0
local oldDown = false
local oldUp = false

function menu:new(o)
	o = o or {}
	self.objects={}
	return setmetatable(o, {__index=self})
end

function menu:update(dt)
	camera.x = 0
	camera.y = 0

	local keyUp = love.keyboard.isDown("up")
	local keyDown = love.keyboard.isDown("down")

	if love.keyboard.isDown("x") then
		screenmanager:setScreen("level1")
	end

	if keyDown and not oldDown and self.curoption < 3 then
		self.curoption = self.curoption + 1
	end

	if keyUp and not oldUp and self.curoption > 1 then
		self.curoption = self.curoption - 1
	end

	oldUp = keyUp
	oldDown = keyDown

	text = "Knightvania"
	

	if k % (math.pi*2) == 0 then
		k = 0
	end
	k = k + 0.1
end

function menu:draw()
	love.graphics.setColor(0,0,0,255)
	love.graphics.rectangle("fill",0,0,128,128)
	love.graphics.setColor(255,255,255,255)
	for i=1,text:len() do
		love.graphics.print(text:sub(i,i), 16+i*8, math.floor(32+math.sin(k+i)*5))
	end

	for i,v in ipairs(self.options) do
		if self.curoption == i then
			love.graphics.print(v, 16, 48 + i * 16)
		else
			love.graphics.print(v, 8, 48 + i * 16)
		end
	end
end