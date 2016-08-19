transition={}

transition.duration=0
transition.func = nil
transition.back = 0
transition.image = love.graphics.newImage("Assets/transition.png")
transition.anim = {
	[1] = love.graphics.newQuad(0,0,32,32,transition.image:getDimensions()),
	[2] = love.graphics.newQuad(16,0,32,32,transition.image:getDimensions()),
	[3] = love.graphics.newQuad(32,0,32,32,transition.image:getDimensions()),
	[4] = love.graphics.newQuad(48,0,32,32,transition.image:getDimensions()),
	[5] = love.graphics.newQuad(64,0,32,32,transition.image:getDimensions()),
	[6] = love.graphics.newQuad(80,0,32,32,transition.image:getDimensions()),
	[7] = love.graphics.newQuad(96,0,32,32,transition.image:getDimensions()),
	[8] = love.graphics.newQuad(112,0,32,32,transition.image:getDimensions()),
	[9] = love.graphics.newQuad(128,0,128,32,32,transition.image:getDimensions())
}

function vish()
	print("transition")
end

function transition:doTransition(vel)
	screenmanager.currentScreen.transition = true
	self.duration = vel
	--self.func = funct
	i = 1
	self.back = 0
	self.image:setFilter("nearest","nearest")
	self.image:setWrap("repeat","repeat")
end

function transition:update()
	if self.back == 0 then
		i = i + self.duration
	else
		i = i - self.duration
	end
	if i >= 12 then
		self.i = table.getn(self.anim)
		screenmanager.currentScreen.player:backToSpawn()
		self.back = 1
	end
	if i < 1 then
		i = 1
		screenmanager.currentScreen.transition = false
	end
end

function transition:draw()
	love.graphics.setColor(0,0,0,255)
	for k=0,(global.height/16) do
		for j=0, (global.width/16) do
			love.graphics.circle("fill",math.abs(camera.x)+j*16,math.abs(camera.y)+k*16,i,8)
		end
	end
	love.graphics.setColor(255,255,255,255)
	--love.graphics.draw(self.image, self.anim[math.floor(i)],0,0)
end