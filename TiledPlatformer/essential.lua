func = {}

function func:distance(x1,x2,y1,y2)
	local dx = x1-x2
	local dy = y1-y2
	return math.sqrt((dx*dx)+(dy*dy))
end

function func:col4Sides(obj1,obj2,dt)
	if obj1 == obj2 then
		return -1
	end
	local w = 0.5*(obj1.width+obj2.width)
	local h = 0.5*(obj1.height+obj2.height)
	local dx = (obj1.x+(obj1.width/2)) - (obj2.x+(obj2.width/2)) -- Tem que ser o CenterX
	local vspeed = obj1.vspeed*dt
	local dy = (obj1.y+(obj1.height/2)) - (obj2.y+(obj2.height/2)) -- Tem que ser o CenterY

	if math.abs(dx) <= w and math.abs(dy) <= h then
		print(obj1.type .. obj1.y)
		dy = dy - vspeed
		local wy = w*dy
		local hx = h*dx
		--[[print(vspeed)
		print('Xobj1: ' .. obj1.x+(obj1.width/2))
		print('Yobj1: ' .. obj1.y+(obj1.height/2))

		print('Xobj2: ' .. obj2.x+(obj2.width/2))
		print('Yobj2: ' .. obj2.y+(obj2.height/2))
		print('X: ' .. dx)
		print('Y: ' .. dy)
		print('W: ' .. w)
		print('H: ' .. h)
		print('WY: ' .. wy)
		print('HX: ' .. hx)

		--io.read()]]

		if wy >= hx then
			if wy >= -hx then
				obj1.y = obj2.y + obj2.height -- Colisão cima
			else
				obj1.x = obj2.x - obj1.width-- Colisão esquerda
			end
		else
			if wy >= -hx then
				obj1.x = obj2.x + obj2.width-- Colisão direita
			else
				obj1.y = obj2.y - obj1.height-- Colisão baixo
			end
		end
		return -1
	end
	return false
end

function func:Clamp(v0,v1,v2)
	if v0 < v1 then
		return v1
	elseif v0 > v2 then
		return v2
	end
	return v0
end

function func:addScreen(name,table)
	table.load()
	game.state[name] = {
		load = table.load,
		update = table.update,
		draw = table.draw
	}
end

function func:setScreen(name)
	game.screenstate = name
end

return func