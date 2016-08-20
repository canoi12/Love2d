powerup=gameobject:new()

function powerup:new(o)
	o = o or {}
	self:load()
	return setmetatable(o, {__index=self})
end

function powerup:showMessage()
	self.message = true
	self.messageTime = 2

	self.messageSound:play()
end

function powerup:load()
	self.kind = 5
	self.image = love.graphics.newImage("Assets/power-up.png")
	self.image:setFilter("nearest","nearest")
	self.message = false
	self.messageTime = 0

	self.messageSound = love.audio.newSource("Assets/sounds/Powerup.wav","static")

	self.texts = {
		["pt"] = {
			[1] = "Pulo Duplo Habilitado",
			[2] = "Dash Habilitado"
		},
		["en"] = {
			[1] = "Double Jump Enabled",
			[2] = "Dash Enabled"
		}
	}
end

function powerup:update(dt)
	self.dy = self.dy + 0.1
	if self.dy % math.pi*2 == 0 then
		self.dy = 0
	end

	if self.messageTime > 0 then
		self.messageTime = self.messageTime - 0.02
	else
		self.message = false
	end

	self.y = (self.y + (math.sin(self.dy)*0.2))
end

function powerup:draw()
	love.graphics.draw(self.image, self.x, self.y,self.angle,self.xscale,self.yscale,self.xorigin,self.yorigin)
	if self.message then
		love.graphics.setColor(0,0,0,125)
		love.graphics.rectangle("fill",math.abs(camera.x),32+math.abs(camera.y),global.width,8)
		love.graphics.setColor(255,255,255,255)
		if self.type == "doublejump" then
			love.graphics.printf(self.texts[global.language][1], math.abs(camera.x),27+math.abs(camera.y),global.width,"center")
		elseif self.type == "dash" then
			love.graphics.printf(self.texts[global.language][2], math.abs(camera.x),27+math.abs(camera.y),global.height,"center")
		end
	end
end