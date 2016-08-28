level = gamescreen:new()

level.objects = {}
level.footprints = {}
level.footErase = 0

function orderByY(a,b)
	return a.y < b.y
end

function level:load()
	player:load()
	bg_image = love.graphics.newImage("assets/bg.png")
	bg_image:setFilter("nearest","nearest")
	bg_image:setWrap("repeat","repeat")
	bg_quad = love.graphics.newQuad(0,0,640,480,16,16)
	table.insert(self.objects,player)

	--[[table.insert(self.objects,camel:new({x=love.math.random(global.roomWidth),y=love.math.random(global.roomHeight)}))
	table.insert(self.objects,camel:new({x=love.math.random(global.roomWidth),y=love.math.random(global.roomHeight)}))]]
	table.insert(self.objects,lion:new({x=love.math.random(global.roomWidth),y=love.math.random(global.roomHeight)}))

	for i=1,10 do
		table.insert(self.objects,camel:new({x=love.math.random(global.roomWidth),y=love.math.random(global.roomHeight)}))
	end
end

function level:update(dt)
	--player:update(dt)
	for i,v in ipairs(self.footprints) do
		v:update(dt)
		if v.erase <= 0 then
			table.remove(self.footprints,i)
		end
	end
	for i,v in ipairs(self.objects) do
		v:update(dt)
	end
	table.sort(self.objects,orderByY)
	camerax = player.x-(global.width/2)
	cameray = player.y-(global.height/2)

	camerax = math.max(0,math.min(camerax,global.roomWidth-global.width))
	cameray = math.max(0,math.min(cameray,global.roomHeight-global.height))

	--[[if self.footErase < 5 then
		self.footErase = self.footErase + 0.5
	else
		table.remove(self.footprints,1)
		self.footErase = 0
	end]]
end

function level:draw()
	--love.graphics.circle("fill",50,50,120)
	love.graphics.push()
	love.graphics.translate(-camerax,-cameray)
	--love.graphics.draw(bg_image,bg_quad,0,0)
	--player:draw()
	for i,v in ipairs(self.footprints) do
		if v.x >= camerax-(global.width/2) and v.x <= camerax+(global.width*1.5) and
			v.y >= cameray-(global.height/2) and v.y <= cameray+(global.height*1.5) then
			v:draw()
		end
	end
	for i,v in ipairs(self.objects) do
		if v.x >= camerax-(global.width/2) and v.x <= camerax+(global.width*1.5) and
			v.y >= cameray-(global.height/2) and v.y <= cameray+(global.height*1.5) then
			v:draw()
		end
	end
	love.graphics.pop()
end