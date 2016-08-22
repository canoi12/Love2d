water=gameobject:new{anim={}}

function water:new(o)
	o = o or {}
	o.quadrant = math.floor(o.x/global.width) + (math.floor(o.y/global.height)*(level1.map.test.width*level1.tilewidth)/global.width)
	self:load()
	return setmetatable(o, {__index=self})
end

function water:load()
	self.image = love.graphics.newImage("Assets/water.png")

	self:addAnim("idle",0,0,8,8,4)
	self.animSpeed=0.25
	self.xorigin = 0
	self.yorigin = 0

	self.bbox = {
		left = 0,
		right = 8,
		top = 0,
		bottom = 8
	}

	self.image:setFilter("nearest","nearest")
end

function water:update(dt)
	self:playAnim()
	--print("teste")
end

function water:draw()
	love.graphics.draw(self.image,self.anim[self.actualAnim][self.frame],self.x,self.y,self.angle,self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin)
	--love.graphics.rectangle("line",self.x+self.bbox.left-self.xorigin,self.y+self.bbox.top-self.yorigin, self.bbox.right-self.bbox.left,self.bbox.bottom-self.bbox.top)
end