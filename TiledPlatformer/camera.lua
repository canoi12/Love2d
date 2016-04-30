camera = {}

camera.x = 0
camera.y = 0
camera.scaleX = 1
camera.scaleY = 1
camera.rotation = 0

function camera:set()
	love.graphics.push()
	love.graphics.rotate(-camera.rotation)
	love.graphics.scale(1/camera.scaleX,1/camera.scaleY)
	love.graphics.translate(-camera.x,-camera.y)
end

function camera:unset()
	love.graphics.pop()
end

function camera:Move(x,y)
	camera.x = funcs:Clamp(x,0,game.roomwidth-(love.graphics:getWidth())) or 0
	camera.y = funcs:Clamp(y,0,game.roomheight-(love.graphics:getHeight())) or 0
end