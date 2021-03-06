bullet = gameobject:new()


function bullet:new(o)
	o = o or {}
	self:load()
	--o.quadrant = math.floor(o.x/global.width) + (math.floor(o.y/global.height)*(level1.map.test.width*level1.tilewidth)/global.width)
	return setmetatable(o, {__index=self})
end

function bullet:collision(obj2)
	if self == obj2 or self.kind == obj2.kind or obj2.kind == 2 then
		return false
	end
	local ob1 = {
		x = self.bbox.left + self.x - self.xorigin,
		y = self.bbox.top + self.y - self.yorigin,
		w = self.bbox.right - self.bbox.left,
		h = self.bbox.bottom - self.bbox.top,
		flip = self.flip
	}
	if self.flip == -1 and self.kind == 3 then
		ob1.xc = (ob1.x-12) + (ob1.w/2)
	else
		ob1.xc = (ob1.x) + (ob1.w/2)
	end
	ob1.yc = ob1.y + (ob1.h/2)
	local ob2 = {
		x = obj2.bbox.left + obj2.x - obj2.xorigin,
		y = obj2.bbox.top + obj2.y - obj2.yorigin,
		w = obj2.bbox.right - obj2.bbox.left,
		h = obj2.bbox.bottom - obj2.bbox.top,
		flip = obj2.flip
	}

	if obj2.flip == -1 and obj2.kind == 3 then
		ob2.xc = (ob2.x-12) + (ob2.w/2)
	else
		ob2.xc = (ob2.x) + (ob2.w/2)
	end
	ob2.yc = ob2.y + (ob2.h/2)

	local w = (ob1.w + ob2.w)/2
	local h = (ob1.h + ob2.h)/2

	local dx = ob1.xc - ob2.xc
	local dy = ob1.yc - ob2.yc

	if math.abs(dx) <= w and math.abs(dy) <= h then
		local wy = y * dy
		local hx = h * dx

		if obj2.kind == 3 then
			return true
		end

		if wy > hx then
			if wy > -hx then
				--self.y = obj2.y + h
			else
				--self.x = obj2.x - w
			end
		else
			if wy > -hx then
				--self.x = obj2.x + w
			else
				--self.y = obj2.y - h
			end
		end
		return true
	end
	return false
end

function bullet:load()
	self.kind = 4
	self.image = love.graphics.newImage("Assets/bullet.png")
	self.image:setFilter("nearest","nearest")

	self.xorigin = 4
	self.yorigin = 4
	self.bbox = {
		left = 2,
		right = 6,
		top = 2,
		bottom = 6
	}
end

function bullet:update(dt)

	if self:collision(screenmanager.currentScreen.player.sword) then
		if screenmanager.currentScreen.player.sword.attack and not self.damage then
			self.destroy = true
		end
	end
	if utils.check_solid(self.x - 3 + self.dx,self.y) or utils.check_solid(self.x + 3 + self.dx, self.y)  then
		self.destroy = true
	end

	if self.flip == -1 then
		table.insert(screenmanager.screens["level1"].particles,particle:new{quadrant=self.quadrant,x=self.x,y=self.y,bounce=0.2,dy=0,speed=love.math.random(1),angle=love.math.random(-5,5),life=5,gravity = 0,radius=love.math.random(3),color={255,241,232}})
	elseif self.flip == 1 then
		table.insert(screenmanager.screens["level1"].particles,particle:new{quadrant=self.quadrant,x=self.x,y=self.y,bounce=0.2,dy=0,speed=love.math.random(1),angle=love.math.random(175,185),life=5,gravity = 0,radius=love.math.random(3),color={255,241,232}})
	end
	if self.x+4 <= math.abs(camera.x) or self.x-4 >= math.abs(camera.x-global.width) then
		self.destroy = true
	end
	self.x = self.x + self.dx

end

function bullet:draw()
	love.graphics.draw(self.image,self.x,self.y,math.rad(self.angle),self.flip*self.xscale,self.yscale,self.xorigin,self.yorigin)
	--love.graphics.rectangle("line",self.x+self.bbox.left-self.xorigin,self.y+self.bbox.top-self.yorigin, self.bbox.right-self.bbox.left,self.bbox.bottom-self.bbox.top)
	--love.graphics.print(self.dx,self.x,self.y)
end

function bullet:keypressed(key)

end