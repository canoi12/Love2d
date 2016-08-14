player=gameobject:new()

player.image = love.graphics.newImage("Assets/warrior.png")
player.image:setFilter("nearest","nearest")
player.width=32
player.height=32
player.actualAnim="idle"
player.orx=16
player.ory=16

--[[player.anim = {
	["idle"] = {
		[1] = love.graphics.newQuad(0,0,32,32,player.image:getDimensions()),
		[2] = love.graphics.newQuad(32,0,32,32,player.image:getDimensions()),
		[3] = love.graphics.newQuad(64,0,32,32,player.image:getDimensions()),
		[4] = love.graphics.newQuad(96,0,32,32,player.image:getDimensions())
	},
	["walk"]={
		[1] = love.graphics.newQuad(0,32,32,32,player.image:getDimensions()),
		[2] = love.graphics.newQuad(32,32,32,32,player.image:getDimensions()),
		[3] = love.graphics.newQuad(64,32,32,32,player.image:getDimensions()),
		[4] = love.graphics.newQuad(96,32,32,32,player.image:getDimensions()),
		[5] = love.graphics.newQuad(128,32,32,32,player.image:getDimensions()),
		[6] = love.graphics.newQuad(160,32,32,32,player.image:getDimensions()),
		[7] = love.graphics.newQuad(192,32,32,32,player.image:getDimensions())
	}
}]]

function player:init()
	player:createAnim("idle",0,0,4,32,32)
	player:createAnim("walk",0,32,7,32,32)
end

function player:update(dt)
	if love.keyboard.isDown("left") then
		player.dx = -(100*dt)
		player.xscale=-1
	elseif love.keyboard.isDown("right") then
		player.dx = (100*dt)
		player.xscale=1
	end

	if not(love.keyboard.isDown("left") or 
		love.keyboard.isDown("right")) then
		player.dx = player.dx*0.75
		self:playAnim("idle")
	else
		self:playAnim("walk")
	end

	
	--if (player.y < 128-player.height) then
	if gamescreen.tmap[math.floor(((player.y-8)/16))+1][math.floor((player.x)/16)] ~= 1 then
		--print(math.floor(player.y/16))
		player.dy = player.dy + gravity
	else
		while gamescreen.tmap[math.floor(((player.y-9)/16))+1][math.floor((player.x)/16)] == 1 do
			player.y = player.y-1
		end
		player.dy= player.dy * -player.bounce
		if love.keyboard.isDown("up") then
			player.dy = -4
		end
	end

	if player.animTime > 1 then
		player.animTime = 0
		player.frame = player.frame + 1
	else
		player.animTime = player.animTime + 0.2
	end

	if player.frame >= table.getn(player.anim[player.actualAnim]) then
		player.frame = 1
	end

	player.x = player.x + player.dx
	player.y = player.y + player.dy
end

function player:draw()
	love.graphics.print((player.y/16),0,0)
	love.graphics.draw(player.image, player.anim[player.actualAnim][player.frame], player.x, player.y, 0, player.xscale, player.yscale,player.orx,player.ory)
end