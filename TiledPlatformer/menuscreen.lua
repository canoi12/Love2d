menuscreen = {}

function menuscreen.load()

end

function menuscreen.update(dt)
	if love.keyboard.isDown("return") then
		funcs:setScreen("game")
	end
end

function menuscreen.draw()
	love.graphics.print("vish",0,0)
end