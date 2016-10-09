menu = gamescreen:new()
menu.title = "Teste Jogo"

local k = 0
local al = 0

function menu:load()
	bg_image = love.graphics.newImage("assets/bg.png")
	bg_image:setFilter("nearest","nearest")
	bg_image:setWrap("repeat","repeat")
	bg_quad = love.graphics.newQuad(0,0,640,480,16,16)
end

function menu:update(dt)
	if love.keyboard.isDown("return") then
		screenmanager:changeLoading("level")
	end
	k = k + 0.2

	if k % math.pi*2 <= 0.1 then
		k = 2
		al = 0
	end
	if love.keyboard.isDown("down") then
		al = 1
	end
end

function menu:draw()
	--love.graphics.circle("fill",50,50,120)
	love.graphics.draw(bg_image,bg_quad,0,0)
	for i=1,string.len(self.title) do
		if al == 1 then
			love.graphics.print(self.title:sub(i,i),i*12,math.sin(k-(i*6))*10)
		else
			love.graphics.print(self.title:sub(i,i),i*12,10)
		end
	end
end