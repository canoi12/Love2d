menu=gamescreen:new()
menu.options = {
	["pt"] = {
		[1] = "Novo jogo",
		[2] = "Creditos",
		[3] = "Sair"
	},
	["en"] = {
		[1] = "New game",
		[2] = "Credits",
		[3] = "Exit"
	}
}

menu.curoption = 1

k = 0
local oldDown = false
local oldUp = false
local oldZ = false

function menu:new(o)
	o = o or {}
	self.objects={}
	self.optionSound = love.audio.newSource("Assets/sounds/Blip_Select.wav","static")
	self.optionSound:setVolume(0.3)
	return setmetatable(o, {__index=self})
end

function menu:update(dt)
	camera.x = 0
	camera.y = 0

	local keyUp = love.keyboard.isDown("up")
	local keyDown = love.keyboard.isDown("down")

	if love.keyboard.isDown("z") and not oldZ then
		if self.curoption == 3 then
			screenmanager:setScreen("level1")
		elseif self.curoption == 2 then
			screenmanager:setScreen("credits")
		elseif self.curoption == 1 then
			love.event.quit()
		end
	end
	oldZ = love.keyboard.isDown("z")

	if keyDown and not oldDown and self.curoption < 3 then
		self.curoption = self.curoption + 1
		self.optionSound:play()
	end

	if keyUp and not oldUp and self.curoption > 1 then
		self.curoption = self.curoption - 1
		self.optionSound:play()
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
		love.graphics.setColor(126,37,83,255)
		love.graphics.print(text:sub(i,i), 4+i*10, 16+math.sin(k+i)*5,0,2)
		love.graphics.setColor(255,0,77,255)
		love.graphics.print(text:sub(i,i), 4+i*10, 16+math.sin(k+i)*4.5,0,2)
		love.graphics.setColor(155,119,168,255)
		love.graphics.print(text:sub(i,i), 4+i*10, 16+math.sin(k+i)*3.5,0,2)
		love.graphics.setColor(255,241,232,255)
		love.graphics.print(text:sub(i,i), 4+i*10, 16+math.sin(k+i)*2.5,0,2)
	end
	love.graphics.setColor(255,255,255,255)

	for i,v in ipairs(self.options[global.language]) do
		if self.curoption == i then
			love.graphics.print(v, 16, math.abs(48 + i * 16))
		else
			love.graphics.print(v, 8, math.abs(48 + i * 16))
		end
	end
end