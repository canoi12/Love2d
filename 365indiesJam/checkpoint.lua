checkpoint = gameobject:new()

function checkpoint:new(o)
	o = o or {}
	self:load()
	return setmetatable(o, {__index=self})
end


function checkpoint:load()
	self.image = love.graphics.newImage("Assets/checkpoint-1.png")
	self.image:setFilter("nearest","nearest")
	self.kind = 5
	self.showKey = false
	self.message = false
	self.messageTime = 2
	self.keyImage = love.graphics.newImage("Assets/keydown.png")
	self.keyImage:setFilter("nearest","nearest")

	self.messageSound = love.audio.newSource("Assets/sounds/Pickup_Coin.wav","static")
end

function checkpoint:showMessage()
	self.message = true
	self.messageTime = 2
	self.messageSound:play()
end

function checkpoint:update(dt)
	self.dy = self.dy + 0.1
	if self.dy % math.pi*2 == 0 then
		self.dy = 0
	end
	--print(self.x)

	if self.messageTime > 0 then
		self.messageTime = self.messageTime - 0.02
	else
		self.message = false
	end

	self.y = (self.y + (math.sin(self.dy)*0.2))
end

function checkpoint:draw()
	love.graphics.draw(self.image, self.x, self.y,self.angle,self.xscale,self.yscale,self.xorigin,self.yorigin)
	if self.showKey then
		love.graphics.draw(self.keyImage, self.x, self.y-12,self.angle,self.xscale,self.yscale,2,2)
	end
end