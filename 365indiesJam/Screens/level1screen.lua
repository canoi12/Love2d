local utf8 = require("utf8")

level1=gamescreen:new()
level1.background={
	image = nil,
	quad = nil,
	x=0,
	y=0,
	dx=0,
	dy=0
}
level1.guardian = nil

local fade = 0.05
local fade2 = 0.05

function level1:load()
	self.map = map:new()
	self.objects={}

	self.map:loadMap("Assets/testemenor.lua")
	self.background.image = love.graphics.newImage("Assets/bg_fix.png")
	self.background.image:setFilter("nearest","nearest")
	self.background.image:setWrap("clampzero","repeat")
	self.background.dx=-0.2
	self.tilewidth = self.map.test.tilewidth
	self.tileheight = self.map.test.tileheight
	self.pause = false
	self.transition = false

	local quadrantNumber = 0

	quadrantNumber = ((self.map.test.width*self.tilewidth)/global.width)*((self.map.test.height*self.tileheight)/global.height)

	for i=0,quadrantNumber-1 do
		self.quadrants[i] = {}
	end

	self.player = player:new()
	self.guardian = guardian:new()
	self.sound = love.audio.newSource("Assets/sounds/Bit Shift.mp3")
	self.sound:setVolume(0.4)
	self.sound:setLooping(true)
	self.sound:play()
	--[[self.player.x = 568
	self.player.y = 88]]

	table.insert(self.objects,self.player)
	self.objects[1].x = 944
	self.objects[1].y = 352
	self.activeSpawn.x = 944	
	self.activeSpawn.y = 352
	--local dol = dolphin:new()
	--table.insert(self.objects,dol)
	self:getObjects()
	self:getSpawns()
	self:getPowerUps()
	self:getBoss()
	self:getWater()
	self:getChest()
	indie:load()
	--print(self.objects[table.getn(self.objects)].quadrant)
	self.background.quad = love.graphics.newQuad(0,0,self.map.test.width*(self.map.test.tilewidth), self.map.test.height*self.map.test.tileheight, self.background.image:getDimensions())
end

function level1:resetEnemies()
	for j=2,table.getn(self.objects) do
		table.remove(self.objects,2)
	end
	--print(table.getn(self.objects))
	self:getObjects()
	self:getBoss()
end

function level1:reset()
	for i, v in ipairs(self.objects) do
		v = nil
	end
	self:load()
end

function level1:update(dt)
	--player:update(dt)
	if not self.pause and not self.transition and not global.write then
		for i,v in ipairs(self.chests) do
			v:update(dt)
		end
		for i,v in ipairs(self.objects) do
			if (v.quadrant == self.activequadrant or v.kind == 1) then
				v:update(dt)
				if v.destroy then
					table.remove(self.objects, i)
				end
			end
		end
		for i,v in ipairs(self.spawns) do
			v:update(dt)
		end
		for i,v in ipairs(self.water) do
			--print(self.activequadrant)
			if v.quadrant == self.activequadrant then
				v:update(dt)
			end
		end
		for i,v in ipairs(self.powerups) do
			v:update(dt)
			if v.destroy and not v.message then
				table.remove(self.powerups, i)
			end
		end
		if self.boss.quadrant == self.activequadrant and self.boss ~= nil and not self.dialogue then
			if not self.boss.destroy and not global.finalBossDialogue then	
				self.boss:update(dt)
			end
		end
		for i,v in ipairs(self.particles) do
			v:update(dt)
			if v.destroy then
				table.remove(self.particles,i)
			end
		end
		indie:update(dt)
	end
	if self.transition then
		transition:update()
	end
	if self.dialogue then
		textbox:update(dt)
	end
	--[[camera.x = -self.objects[1].x+(global.width/2)
	camera.y = -self.objects[1].y+(global.height/2)]]

	utils.cameraBound()
	self.background.x = self.background.x+(self.background.dx)
	self.background.y = self.background.y + self.background.dy
	if self.background.x <= -global.width then
		self.background.x = 0
	end
	self.guardian:update(dt)
	if global.finalFinalCutscene and not global.finalFinalCutsceneStart then
		fade = fade + 0.05
	end

	if global.finalFinalCutsceneEnd then
		fade2 = fade2 + 0.05
	end

	--[[if love.keyboard.isDown("r") then
		self:reset()
		global:resetSave()
	end]]
	--player:update(dt)
	--dol:update(dt)
end

function level1:draw()
	love.graphics.draw(self.background.image, self.background.quad,self.background.x,self.background.y)
	love.graphics.draw(self.background.image, self.background.quad,self.background.x+128,self.background.y)
	love.graphics.translate(camera.x, camera.y)
	self.map:draw()
	--player:draw()
	self.guardian:draw()
	if self.boss ~= nil and self.activequadrant == 71 then
		if not global.finalFinalCutscene then
			self.boss:draw()
		end
	end
	for i,v in ipairs(self.spawns) do
		v:draw()
	end
	for i,v in ipairs(self.chests) do
		v:draw()
	end
	for i,v in ipairs(self.objects) do
		if (v.quadrant == self.activequadrant or v.kind == 1) then
			v:draw()
		end
	end
	for i,v in ipairs(self.water) do
		--if v.quadrant == self.activequadrant then
			v:draw()
		--end
	end
	for i,v in ipairs(self.powerups) do
		v:draw()
	end
	for i,v in ipairs(self.spawns) do
		if v.message then
			love.graphics.setColor(0,0,0,125)
			love.graphics.rectangle("fill",math.abs(camera.x),32+math.abs(camera.y),global.width,8)
			love.graphics.setColor(255,255,255,255)
			if global.language == "pt" then
				love.graphics.printf("Jogo Salvo", math.abs(camera.x),27+math.abs(camera.y),global.width,"center")
			elseif global.language == "en" then
				love.graphics.printf("Game Saved", math.abs(camera.x),27+math.abs(camera.y),global.width,"center")
			end
		end
	end
	for i,v in ipairs(self.particles) do
		v:draw()
	end
	indie:draw()
	if self.transition then
		transition:draw()
	end
	if self.dialogue then
		textbox:draw()
	end
	if global.finalFinalCutscene and not global.finalFinalCutsceneStart then
		love.graphics.setColor(255,255,255,math.sin(fade)*127+127)
		love.graphics.rectangle("fill",math.abs(camera.x),math.abs(camera.y),global.width,global.height)
		love.graphics.setColor(255,255,255,255)
	
		if math.sin(fade)*127+127 <= 1 then
			global.finalFinalCutsceneStart = true
			textbox:createDialogue(24,30)
		end
	end

	if global.finalFinalCutsceneEnd then
		love.graphics.setColor(0,0,0,fade2*127)
		love.graphics.rectangle("fill",math.abs(camera.x),math.abs(camera.y),global.width,global.height)
		love.graphics.setColor(255,255,255,255)
		if fade2 >= 1.8 then
			screenmanager:setScreen("menu")
		end
	end

	if global.write then
		love.graphics.setColor(0,0,0,125)
		love.graphics.rectangle("fill",math.abs(camera.x),32+math.abs(camera.y),global.width,8)
		love.graphics.setColor(255,255,255,255)
		if global.language == "pt" then
			love.graphics.printf("Digite a senha:", math.abs(camera.x),17+math.abs(camera.y),global.width,"center")
			love.graphics.printf("ESC para cancelar.", 16+math.abs(camera.x),37+math.abs(camera.y),global.width,"center")
		elseif global.language == "en" then
			love.graphics.printf("Enter the password:", math.abs(camera.x),17+math.abs(camera.y),global.width,"center")
			love.graphics.printf("ESC to cancel.", 16+math.abs(camera.x),37+math.abs(camera.y),global.width,"center")
		end
		love.graphics.printf(global.senha, math.abs(camera.x),27+math.abs(camera.y),global.width,"center")
	end
	--player:draw()
	--dol:draw()
end

function level1:keypressed(key)
	player:keypressed(key)
	for i,v in ipairs(level1.objects) do
		v:keypressed(key)
	end
	if key == "z" and self.dialogue then
		textbox:next()
	end
	if key == "backspace" then
		if global.write then
        -- get the byte offset to the last UTF-8 character in the string.
	        local byteoffset = utf8.offset(global.senha, -1)
	 
	        if byteoffset then
	            -- remove the last UTF-8 character.
	            -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
	            global.senha = string.sub(global.senha, 1, byteoffset - 1)
	        end
		end
	end
end

function level1:joystickpressed(joy, button)
	if button == 1 and self.dialogue then
		textbox:next()
	end
	if button == 2 then
		if global.write then
        -- get the byte offset to the last UTF-8 character in the string.
	        local byteoffset = utf8.offset(global.senha, -1)
	 
	        if byteoffset then
	            -- remove the last UTF-8 character.
	            -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
	            global.senha = string.sub(global.senha, 1, byteoffset - 1)
	        end
		end
	end
end

function level1:textinput(t)
	if global.write then
		global.senha = global.senha .. t
	else
		global.senha = ""
	end
	if string.lower(global.senha) == "batata doce" or string.lower(global.senha) == "batatadoce" then
		global.write = false
		--player.firesword = true
	end
end