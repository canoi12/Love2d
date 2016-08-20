credits=gamescreen:new()
credits.y = 0

local oldZ = false

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
Todo o resto: Canoi Gomes de Aguiar (twitter:@canoi12)\
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
All the rest: Canoi Gomes de Aguiar (twitter:@canoi12)\
"
	}
}

function credits:load()

end

function credits:update(dt)
	if love.keyboard.isDown("down") and self.y > -30 then
		self.y = self.y - 5
	elseif love.keyboard.isDown("up") and self.y < 0 then
		self.y = self.y + 5
	end

	if love.keyboard.isDown("z") and not oldZ then
		screenmanager:setScreen("menu")
	end
	oldZ = love.keyboard.isDown("z")

end

function credits:draw()
	love.graphics.clear()
	love.graphics.printf(self.text[global.language],0,self.y,global.width)
end
