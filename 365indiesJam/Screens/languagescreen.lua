language=gamescreen:new()
language.options = {
	[1] = "Português",
	[2] = "English"
}

language.languages = {
	[1] = "pt",
	[2] = "en"
}

language.curoption = 1

k = 0
local oldDown = false
local oldUp = false
local oldZ = true

function language:new(o)
	o = o or {}
	self.objects={}
	self.optionSound = love.audio.newSource("Assets/sounds/Blip_Select.wav","static")
	self.optionSound:setVolume(0.3)
	return setmetatable(o, {__index=self})
end

function language:update(dt)
	camera.x = 0
	camera.y = 0

	local keyUp = love.keyboard.isDown("up")
	local keyDown = love.keyboard.isDown("down")

	if love.keyboard.isDown("z") and not oldZ then
		screenmanager:setScreen("menu")
	end
	oldZ = love.keyboard.isDown("z")

	if keyDown and not oldDown and self.curoption < 2 then
		self.curoption = self.curoption + 1
		self.optionSound:play()
	end

	if keyUp and not oldUp and self.curoption > 1 then
		self.curoption = self.curoption - 1
		self.optionSound:play()
	end

	oldUp = keyUp
	oldDown = keyDown

	global.language = self.languages[self.curoption]

	if k % (math.pi*2) == 0 then
		k = 0
	end
	k = k + 0.1
end

function language:draw()
	love.graphics.setColor(255,255,255,255)

	love.graphics.printf("Idioma",0,32,global.width,"center")
	for i,v in ipairs(self.options) do
		if self.curoption == i then
			love.graphics.print("-"..v, 16, math.abs(48 + i * 16))
		else
			love.graphics.print(v, 8, math.abs(48 + i * 16))
		end
	end
end