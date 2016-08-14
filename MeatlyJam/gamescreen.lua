gamescreen={}

gamescreen.mapName="level1"

gamescreen.map = love.filesystem.load("Assets/level1.lua")
gamescreen.image = love.graphics.newImage("Assets/ground.png")
gamescreen.image:setFilter("nearest","nearest")
gamescreen.test=gamescreen.map()
gamescreen.tmap = {}

gamescreen.tilemap = {
	[1] = love.graphics.newQuad(0,0,16,16,32,16),
	[2] = love.graphics.newQuad(16,0,16,16,32,16)
}
data = gamescreen.test.layers[1].data
function gamescreen:init()
	x = 0
	y = 0
	k=0
	gamescreen.tmap[y] = {}
	gamescreen.tmap[y][x]=0
	y=-1
	--[[for i,v in ipairs(data) do
		k = k + 1
		gamescreen.tmap[y][x]=v
		x = x + 1
		if x > 49 then
			x = 0
			y = y + 1
			if y < 50 then
				gamescreen.tmap[y] = {}
				gamescreen.tmap[y][x]=v
			end
		end
		print(k,x,y, v)
	end]]
	for i,v in ipairs(data) do
		if y==-1  then
			y=0
			k=1
		else
			x = k % 50
			if x == 0 then
				y = y+1
				gamescreen.tmap[y]={}
			end
			print(x,y)
			gamescreen.tmap[y][x]=v
			--print(k,x,y, v)
			--print(x,y)
			k = k + 1
		end
	end
end

function gamescreen:draw()
	k=0

	x = 0
	y = 0
	for i,v in ipairs(data) do
		--print(v)
		if v ~= 0 then
			love.graphics.draw(gamescreen.image,gamescreen.tilemap[v],x*16,y*16)
		end
		x = x + 1
		if x >= 50 then
			x = 0
			y = y + 1
		end
	end

	--[[for y=0,49 do
		for x=0,49 do
			--print("wow",x,y)
			--love.graphics.print(gamescreen.tmap[y][x],x*16,y*16)
		end
	end
	--[[for y=0,gamescreen.test.height do
		for x=0,gamescreen.test.width do
			k = k+1
			if gamescreen.test.layers[1].data[k] ~= 0 then
				love.graphics.draw(gamescreen.image,gamescreen.tilemap[gamescreen.test.layers[1].data[k],x*16,y*16)
			end
		end
	end]]
end