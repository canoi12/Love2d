local map = {}

function map:new(o)
	o = o or {}
	return setmetatable(o, {__index=self})
end

function map:updateTilesetBatch()
	self.tilesetBatch:clear()
	k=0
	x = 0
	y = 0
	for j,datav in ipairs(self.map.layers) do
		k=0
		x = 0
		y = 0
		if datav.type == "tilelayer" then
			for i,v in ipairs(datav.data) do
				if v ~= 0 then
					self.tilesetBatch:add(self.tilemap[v],x*self.map.tilewidth,y*self.map.tileheight)
				end
				x = x + 1
				if x >= self.map.width then
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
	self.map = self.map()
	self.image = {}
	self.tmap = {}
	self.objects={}
	data = self.map.layers[1].data
	self.tilemap = {}
	x = 0
	y = 0
	k=0
	self.tmap[y] = {}
	self.tmap[y][x]=0

	for i,v in ipairs(self.map.tilesets) do
		imgWidth = v.imagewidth / v.tilewidth
		imgHeight = v.imageheight / v.tileheight

		table.insert(self.image, love.graphics.newImage("assets/"..v.image))
		self.image[i]:setFilter("nearest","nearest")

		for yy=1,imgHeight do
			for xx=1,imgWidth do
				table.insert(self.tilemap,love.graphics.newQuad((xx-1)*v.tilewidth, (yy-1)*v.tileheight, v.tilewidth, v.tileheight, self.image[i]:getDimensions()))
			end
		end
	end
	self.tilesetBatch = love.graphics.newSpriteBatch(self.image[1],self.map.width*self.map.height)

	self:updateTilesetBatch()

	k=0
	y=-1
	for i,v in ipairs(data) do
		if y==-1  then
			y=0
			k=1
		else
			x = k % (self.map.width)
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
	love.graphics.draw(self.tilesetBatch)
end

return map