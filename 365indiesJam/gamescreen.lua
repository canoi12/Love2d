gamescreen={}
gamescreen.map={}
gamescreen.objects={}
gamescreen.background={
	image = nil,
	quad = nil,
	x=0,
	y=0,
	dx=0,
	dy=0
}

gamescreen.activequadrant = 0

gamescreen.quadrants = {}
gamescreen.spawns={}
gamescreen.activeSpawn={x=0,y=0}
gamescreen.dialogue = false

gamescreen.powerups = {}
gamescreen.boss = nil
gamescreen.water = {}
gamescreen.chests = {}

gamescreen.particles = {}

function gamescreen:new(o)
	o = o or {}
	self:load()
	return setmetatable(o, {__index=self})
end

function gamescreen:load()
	self.map = map:new()
	self.objects={}
end

function gamescreen:reset()
	for i, v in ipairs(self.objects) do
		v = nil
	end
	self:load()
end

function gamescreen:getObjects()
	for j,datav in ipairs(self.map.test.layers) do
		if datav.type == "objectgroup" then
			for i,v in ipairs(datav.objects) do
				if v.name == "Dolphin" then
					table.insert(self.objects,dolphin:new{x=v.x,y=v.y})
				elseif v.name == "Coelho" then
					table.insert(self.objects,bunny:new{x=v.x,y=v.y})
				end
			end
		end
	end
end

function gamescreen:getSpawns()
	for j,datav in ipairs(self.map.test.layers) do
		if datav.type == "objectgroup" then
			for i,v in ipairs(datav.objects) do
				if v.name == "Checkpoint" then
					table.insert(self.spawns,checkpoint:new{x=v.x,y=v.y})
				end
			end
		end
	end
end

function gamescreen:getPowerUps()
	for j,datav in ipairs(self.map.test.layers) do
		if datav.type == "objectgroup" then
			for i,v in ipairs(datav.objects) do
				if v.name == "DoubleJump" and not level1.player.candoublejump then
					table.insert(self.powerups,powerup:new{x=v.x,y=v.y,type="doublejump"})
				elseif v.name == "Dash" and not level1.player.candash then
					table.insert(self.powerups,powerup:new{x=v.x,y=v.y,type="dash"})
				end
			end
		end
	end
end

function gamescreen:getBoss()
	for j,datav in ipairs(self.map.test.layers) do
		if datav.type == "objectgroup" then
			for i,v in ipairs(datav.objects) do
				if v.name == "Boss" then
					self.boss = boss:new({x=v.x,y=v.y,minions={}})
				end
			end
		end
	end
end

function gamescreen:getWater()
	for j,datav in ipairs(self.map.test.layers) do
		if datav.type == "objectgroup" then
			for i,v in ipairs(datav.objects) do
				if v.name == "Water" then
					table.insert(self.water,water:new({x=v.x,y=v.y}))
				end
			end
		end
	end
end

function gamescreen:getChest()
	for j,datav in ipairs(self.map.test.layers) do
		if datav.type == "objectgroup" then
			for i,v in ipairs(datav.objects) do
				if v.name == "Bau" then
					table.insert(self.chests, chest:new({x=v.x,y=v.y,type=v.type,insideimage=nil}))
				end
			end
		end
	end
end

function gamescreen:reset()
end

function gamescreen:update(dt)
end

function gamescreen:draw()
end

function gamescreen:keypressed(key)
end