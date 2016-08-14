menu=gamescreen:new()


function menu:new(o)
	o = o or {}
	self.objects={}
	return setmetatable(o, {__index=self})
end

function menu:update(dt)
	camera.x = 0
	camera.y = 0

	if love.keyboard.isDown("x") then
		screenmanager:setScreen("level1")
	end
end

function menu:draw()
	love.graphics.print("Menu funcionando!!", 0, 64)
end