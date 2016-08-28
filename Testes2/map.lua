map = {}

function map:new(o)
	o = o or {}
	return setmetatable(o, {__index=self})
end

function map:updateTilesetBatch()
	self.tilesetBatch:clear()
	k=0
	x = 0
	y = 0
	for j,datav in ipairs(self.test.layers) do
		k=0
		x = 0
		y = 0
		if datav.type == "tilelayer" then
			for i,v in ipairs(datav.data) do
				if v ~= 0 then
					self.tilesetBatch:add(self.tilemap[v],x*self.test.tilewidth,y*self.test.tileheight)
				end
				x = x + 1
				if x >= self.test.width then
					x = 0
					y = y + 1
				end
			end
		end
	end
	self.tilesetBatch:flush()
end

function map:loadMap(name)
	self.map = love.filesystem.load(name)
	self.test = self.map()
	self.image = {}
	self.tmap = {}
	self.objects={}
	data = self.test.layers[1].data
	--print(table.getn(data))
	self.tilemap = {}
	x = 0
	y = 0
	k=0
	self.tmap[y] = {}
	self.tmap[y][x]=0

	for i,v in ipairs(self.test.tilesets) do
		imgWidth = v.imagewidth / v.tilewidth
		imgHeight = v.imageheight / v.tileheight

		table.insert(self.image, love.graphics.newImage("Assets/"..v.image))
		self.image[i]:setFilter("nearest","nearest")
		--print(map.image[1])

		for yy=1,imgHeight do
			for xx=1,imgWidth do
				table.insert(self.tilemap,love.graphics.newQuad((xx-1)*v.tilewidth, (yy-1)*v.tileheight, v.tilewidth, v.tileheight, self.image[i]:getDimensions()))
			end
		end
	end
	self.tilesetBatch = love.graphics.newSpriteBatch(self.image[1],self.test.width*self.test.height)

	self:updateTilesetBatch()

	k=0
	y=-1
	for i,v in ipairs(data) do
		if y==-1  then
			y=0
			k=1
		else
			x = k % (self.test.width)
			if x == 0 then
				y = y+1
				self.tmap[y]={}
			end
			self.tmap[y][x]=v
			k = k + 1
		end
	end
end

function map:draw()
	--[[k=0
	x = 0
	y = 0
	for i,v in ipairs(data) do
		if v ~= 0 then
			love.graphics.draw(map.image[1],map.tilemap[v],x*16,y*16)
		end
		x = x + 1
		if x >= 50 then
			x = 0
			y = y + 1
		end
	end]]
	love.graphics.draw(self.tilesetBatch)
end