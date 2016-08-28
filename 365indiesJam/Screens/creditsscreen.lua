credits=gamescreen:new()
credits.y = 0

local oldZ = true

credits.text ={
	["pt"] = {
		[1] = "Bit Shift Kevin MacLeod (incompetech.com) \
Licensed under Creative Commons: By Attribution 3.0 License \
http://creativecommons.org/licenses/by/3.0/\
\
Efeitos sonoros feitos no: bfxr.net\
\
Fonte: TinyUnicode by DuffsDevice - license : (Creative Commons Attribution)\
\
Arte e Programação: Canoi Gomes de Aguiar (twitter:@canoi12)\
"
	},
	["en"] = {
		[1] = "Bit Shift Kevin MacLeod (incompetech.com) \
Licensed under Creative Commons: By Attribution 3.0 License \
http://creativecommons.org/licenses/by/3.0/\
\
Sonore effects made on: bfxr.net\
\
Fonte: TinyUnicode by DuffsDevice - license : (Creative Commons Attribution)\
\
Art and Programming: Canoi Gomes de Aguiar (twitter:@canoi12)\
"
	}
}

function credits:load()

end

function credits:update(dt)

	local keyUp = love.keyboard.isDown("up") or (Joystick[1]:getAxis(2) < -0.4)
	local keyDown = love.keyboard.isDown("down") or (Joystick[1]:getAxis(2) > 0.4)
	local keyZ = love.keyboard.isDown("z") or (Joystick[1]:isDown(1))

	if keyUp and self.y > -50 then
		self.y = self.y - 5
	elseif keyDown and self.y < 0 then
		self.y = self.y + 5
	end

	if keyZ and not oldZ then
		screenmanager:setScreen("menu")
	end
	oldZ = keyZ

end

function credits:draw()
	love.graphics.clear()
	love.graphics.printf(self.text[global.language],0,self.y,global.width)
end
