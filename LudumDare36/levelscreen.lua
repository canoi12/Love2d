level = gamescreen:new()

function level:load()
	player:load()
	bg_image = love.graphics.newImage("assets/bg.png")
	bg_image:setFilter("nearest","nearest")
	bg_image:setWrap("repeat","repeat")
	bg_quad = love.graphics.newQuad(0,0,640,480,16,16)
end

function level:update(dt)
	player:update(dt)
	camerax = player.x-(global.width/2)
	cameray = player.y-(global.height/2)

	camerax = math.max(0,math.min(camerax,640-global.width))
	cameray = math.max(0,math.min(cameray,480-global.height))
end

function level:draw()
	--love.graphics.circle("fill",50,50,120)
	love.graphics.push()
	love.graphics.translate(-camerax,-cameray)
	--love.graphics.draw(bg_image,bg_quad,0,0)
	player:draw()
	love.graphics.pop()
end