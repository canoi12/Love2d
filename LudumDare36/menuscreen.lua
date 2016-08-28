menu = gamescreen:new()

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
end

function menu:draw()
	--love.graphics.circle("fill",50,50,120)
	love.graphics.draw(bg_image,bg_quad,0,0)
end