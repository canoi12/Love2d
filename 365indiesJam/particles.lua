particle=gameobject:new()
particle.radius = 4
particle.alpha = 255
particle.color = {255,0,77}
particle.fade = false
particle.initialLife = 0

function particle:new(o)
	o = o or {}
	self:load()
	self.initialLife = o.life
	--o.quadrant = math.floor(o.x/global.width) + (math.floor(o.y/global.height)*(level1.map.test.width*level1.tilewidth)/global.width)
	return setmetatable(o, {__index=self})
end

function particle:load()
	self.kind = 7
	--self.image = love.graphics.newImage("Assets/particle.png")
	--self.image:setFilter("nearest","nearest")
	self.gravity = 0.0
end

function particle:update(dt)
	if not utils.check_solid(self.x, self.y+2) then
		self.dy = self.dy + self.gravity
	else
		--while map.tmap[math.floor(((self.y-9)/16))+1][math.floor((self.x)/16)] == gamescreen.map.test.tilesets[1].tiles[1].id+1 do
		--self.destroy = true
		while utils.check_solid(self.x,self.y+1) do
			self.y = self.y-1
		end
		self.dy = self.dy * -self.bounce
	end


	if self:collision(screenmanager.currentScreen.player.sword) then
		if screenmanager.currentScreen.player.sword.attack and not self.damage then
			--self.destroy = true
		end
	end
	if utils.check_solid(self.x - 3 + self.dx,self.y) or utils.check_solid(self.x + 3 + self.dx, self.y)  then
		self.angle=-self.angle
	end

	if self.x+4 <= math.abs(camera.x) or self.x-4 >= math.abs(camera.x-global.width) then
		self.destroy = true
	end
	self.life = self.life - 1

	if self.life <= 0 then
		self.destroy = true
	end
	self.x = self.x + (self.speed * math.cos(self.angle) + self.dx)
	self.y = self.y + (self.speed * math.sin(self.angle) + self.dy)

	if self.fade then
		self.alpha = 255*self.life/self.initialLife
	end
end
function particle:draw()
	if self.image ~= nil then
		love.graphics.draw(self.image,self.x,self.y,0,self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin)
	else
	--love.graphics.rectangle("line",self.x+self.bbox.left-self.xorigin,self.y+self.bbox.top-self.yorigin, self.bbox.right-self.bbox.left,self.bbox.bottom-self.bbox.top)
	--love.graphics.print(self.dx,self.x,self.y)
		love.graphics.setColor(self.color,self.alpha)
		love.graphics.circle("fill",self.x,self.y,self.radius)
		love.graphics.setColor(255,255,255,255)
	end
end

function particle:keypressed(key)

end