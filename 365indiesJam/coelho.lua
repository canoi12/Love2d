bunny=gameobject:new({anim={}})

function bunny:new(o)
	o = o or {}
	self.x=64
	self:load()
	return setmetatable(o, {__index=self})
end

function bunny:load()
	self.image = love.graphics.newImage("Assets/coelho.png")

	self:addAnim("idle",0,0,16,16,2)
	self:addAnim("shoot",0,16,16,16,4)
	self.bounce = 0.2
	self.animSpeed=0.25

	self.image:setFilter("nearest","nearest")
end

function bunny:move()
	local xprevious = self.x
	local yprevious = self.y
	if not utils.check_solid(self.x, self.y-10+16) then
		self.dy = self.dy + self.gravity
	else
		--while map.tmap[math.floor(((self.y-9)/16))+1][math.floor((self.x)/16)] == gamescreen.map.test.tilesets[1].tiles[1].id+1 do
		while utils.check_solid(self.x,self.y-11+16) do
			self.y = self.y-1
		end
		self.dy = self.dy * -self.bounce
	end
	for i,v in ipairs(screenmanager.currentScreen.objects) do
		if v.kind == 1 and utils.distanceToPoint(self.x,self.y,v.x,v.y) < 32 then
			self:setAnim("shoot")
			self.flip = utils.sign(v.x - self.x)
			break
		else
			self:setAnim("idle")
		end
	end
	self.y = self.y + self.dy
end

function bunny:update(dt)
	self:playAnim()
	self:move()
end

function bunny:draw()
	love.graphics.draw(self.image,self.anim[self.actualAnim][self.frame],self.x,self.y,self.angle,self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin)
	love.graphics.rectangle("line",self.x+self.bbox.left-self.xorigin,self.y+self.bbox.top-self.yorigin, self.bbox.right,self.bbox.bottom)
end