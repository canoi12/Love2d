local socket = require "socket"

local address, port = "localhost", 12345

local entity
local updaterate = 0.1

local world = {}
local t

function love.load()
	udp = socket.udp()

	udp:settimeout(0)
	udp:setpeername(address, port)

	math.randomseed(os.time())
	entity = tostring(math.random(99999))

	local dg = string.format("%s %s %d %d", entity, 'at', 320, 240)
	udp:send(dg)

	t = 0
end

function love.update(dt)
	t = t + dt

	if t > updaterate then
		local x,y = 0, 0
		if love.keyboard.isDown('up') then y = y-(200*t) end
		--if love.keyboard.isDown('down') then y = y+(100*t) end
		y = y + (50*t)
		if love.keyboard.isDown('left') then x = x-(100*t) end
		if love.keyboard.isDown('right') then x = x+(100*t) end
		local dg = string.format("%s %s %f %f", entity, 'move', x, y)
		udp:send(dg)
		local dg = string.format("%s %s $", entity, 'update')
		udp:send(dg)

		t = t-updaterate
	end

	repeat
		data, msg = udp:receive()

		if data then
			print(data)
			ent, cmd, parms = data:match("^(%S*) (%S*) (.*)")
			if cmd == 'at' then
				local x, y = parms:match("^(%-?[%d.e]*) (%-?[%d.e]*)$")
				assert(x and y)
				x, y = tonumber(x), tonumber(y)
				world[ent] = {x=x,y=y}
			else
				print('unrecognised command:',cmd)
			end
		elseif msg ~= 'timeout' then
			error("Network error: " .. tostring(msg))

		end
	until not data
end

function love.draw()
	for k, v in pairs(world) do
		love.graphics.print(k, v.x, v.y)
		love.graphics.circle("fill",v.x,v.y,10)
	end
	love.graphics.print(table.getn(world), 0,0)
end