gamescreen = {}
enemies = {}
blocks = {}
objects = {}

function gamescreen:loadMap(name)
	local map = love.filesystem.load(name)()
	for i,v in ipairs(map) do
		if(v.type == 'enemy') then
			local newEnemy = enemy:new(v.x,v.y,v.width,v.height)
			table.insert(objects,newEnemy)
			table.insert(enemies,newEnemy)
		elseif v.type == 'block' then
			local newBlock = block:new(v.x,v.y,v.width,v.height)
			table.insert(objects,newBlock)
			table.insert(blocks,newBlock)
		end
	end
end

function gamescreen:load()
	Amora = player:new()
	Amora:load()
	block:load()
	gamescreen:loadMap('level1.map')
	table.insert(objects,Amora)
end

function gamescreen:update(dt)
	--Amora:update(dt)
	--block:update(dt)
	for i,b in ipairs(objects) do
		b:update(dt)
	end

	camera:Move(Amora.x - (love.graphics:getWidth()/2),Amora.y-(love.graphics:getHeight()/2))
end

function gamescreen:draw()
	camera:set()
	--Amora:draw()
	for i,e in ipairs(objects) do
		e:draw()
	end
	camera:unset()
end

--[[function love.mousepressed(x,y,bt)
	if bt == 1 then
		
	elseif bt == 2 then

	end
end]]