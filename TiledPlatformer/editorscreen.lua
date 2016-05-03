editorscreen = {}
local objects = {}
local player = {}
local blocks = {}
local enemies = {}
local editing = false
local editXY = false
local editWH = false
local camx = 0
local camy = 0
local object = ""
local workingDir = love.filesystem.getWorkingDirectory()

function editorscreen:Save(name)
	local file = love.filesystem.newFile(name,"w")
	file:write("local objects = { \n")
	for i, obj in ipairs(objects) do
		file:write("{")
		--[[for j,ob in ipairs(obj) do
			file:write(ob)
			file:write(",")
		end]]
		file:write('x='..obj.x..',')
		file:write('y='..obj.y..',')
		file:write('width='..obj.width..',')
		file:write('height='..obj.height..',')
		file:write('type="'..obj.type..'"')
		file:write("}, \n")
	end
	file:write("nil} \n")
	file:write("return objects")
	file:close()
end

function editorscreen:changeObj()
	if love.keyboard.isDown("1") then
		object = "block"
	elseif love.keyboard.isDown("2") then
		object = "enemy"
	end
end

function editorscreen:moveCamera(dt)
	local windowCenterX = love.graphics:getWidth()/2
	local windowCenterY = love.graphics:getHeight()/2
	local mousex = love.mouse:getX()
	local mousey = love.mouse:getY()
	if love.keyboard.isDown("left") and camx > 0 then
		camx = camx - (400*dt)
	elseif love.keyboard.isDown("right") and camx < game.roomwidth-windowCenterX then
		camx = camx + (400*dt)
	end

	camera:Move(camx,camy)
end

function editorscreen:Drawing(dt)
	local mousex = love.mouse:getX()
	local mousey = love.mouse:getY()

	if love.mouse.isDown(1) then
		for i,b in ipairs(objects) do
			if funcs:distance(mousex+camera.x,b.x,mousey+camera.y,b.y) < 12 then
				editXY = true
				editWH = false
			elseif funcs:distance(mousex+camera.x,b.x+b.width,mousey+camera.y,b.y+b.height) < 12 then
				editXY = false
				editWH = true
			end
			if editXY and b.ativo then
				b.x = mousex+camera.x
				b.y = mousey+camera.y
				b.x = funcs:Clamp(b.x,0,game.roomwidth)
				b.y = funcs:Clamp(b.y,0,game.roomheight)
			elseif editWH and b.ativo then
				b.width = mousex+camera.x - b.x
				b.height = mousey+camera.y - b.y
				b.width = funcs:Clamp(b.width,0,game.roomwidth-b.x)
				b.height = funcs:Clamp(b.height,0,game.roomheight-b.y)
			end
		end
	end
	if not(love.mouse.isDown(1)) then
		editXY = false
		editWH = false
	end
end

function editorscreen:load()
	
end

function editorscreen:update(dt)
	if love.keyboard.isDown("s") then
		--love.filesystem.newFile('home/canoi/Documents/map/level1.map')
		editorscreen:Save('level1.map')
	end
	editorscreen:changeObj()
	editorscreen:moveCamera(dt)
	editorscreen:Drawing(dt)
	if love.keyboard.isDown("return") then
		gamescreen:loadMap('level1.map')
		funcs:setScreen("game")
	end
end

function editorscreen:draw()
	camera:set()
	love.graphics.rectangle("line",0,0,game.roomwidth,game.roomheight)
	for i,obj in ipairs(objects) do
		obj:draw()
	end
	camera:unset()
end

function love.mousepressed(x,y,btn)
	if btn == 1 then
		for i,b in ipairs(objects) do
			if x+camera.x > b.x-6 and x+camera.x < b.x+6 + b.width and y+camera.y > b.y-6 and y+camera.y < b.y+b.height+6 and not(editing) then
				b.ativo = true
				editing = true
			end
		end
	elseif btn == 2 then
		if not(editing) then
			if object == "block" then
				newBlock = block:new(x+camera.x,y+camera.y)
				print(newBlock.x)
				table.insert(objects,newBlock)
				--table.insert(blocks,newBlock)
			elseif object == "enemy" then
				newEnemy = enemy:new(x+camera.x,y+camera.y)
				table.insert(objects,newEnemy)
			end
		end
		editing = false
		editWH = false
		editXY = false
		for i,b in ipairs(objects) do
			if b.ativo then
				b.ativo = false
			end
		end
	end
end