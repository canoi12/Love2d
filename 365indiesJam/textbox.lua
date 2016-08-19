textbox = {}

textbox = {
	["pt"] = {
		[1] = {
			image = 2,
			text ="Ola, jovem guerreiro."
		},
		[2] = {
			image = 1,
			text = "Quem e voce?"
		},
		[3] = {
			image = 2,
			text = "Me desculpe, sou o guardiao desta dimensao."
		},
		[4] = {
			image = 1,
			text = "Desta dimensao?! O que quer dizer?"
		},
		[5] = {
			image = 2,
			text = "Sim, voce esta em outra dimensao, para ser mais exato estamos na dimensao 45."
		},
		[6] = {
			image = 1,
			text = "Mas entao o que estou fazendo aqui?"
		},
		[7] = {
			image = 2,
			text = "Bom, eu te trouxe pra ca."
		},
		[8] = {
			image = 1,
			text = "O que? Como assim?"
		},
		[9] = {
			image = 2,
			text = "Bom, um tempo atras, um objeto misterioso veio parar aqui nesta dimensao."
		},
		[10] = {
			image = 2,
			text = "Isso gerou algum tipo de incoerencia nesse mundo, trazendo criaturas de outras realidades para ca."
		},
		[11] = {
			image = 2,
			text = "No seu mundo voce e um heroi. Entao eu te suplico, por favor, salve este mundo."
		},
		[12] = {
			image = 1,
			text = "Mas por que eu? Com tantos universos devem haver outros herois por ai."
		},
		[13] = {
			image = 2,
			text = "Bem, o Goku estava ocupado salvando a terra mais uma vez..."
		},
		[14] = {
			image = 1,
			text = "-.-'... Ja que e assim, por mim ta tudo bem. Eu vou salvar seu mundo!"
		},
		[15] = {
			image = 2,
			text = "Muito obrigado, guerreiro. Boa sorte na sua jornada."
		}
	}
}

textbox.image = love.graphics.newImage("Assets/portraits.png")

textbox.portraits = {
	[1] = love.graphics.newQuad(0,0,24,24,textbox.image:getDimensions()),
	[2] = love.graphics.newQuad(24,0,24,24,textbox.image:getDimensions())
}

textbox.language = "pt"
textbox.inicio = 0
textbox.fim = 0

textbox.active = false
textbox.time = 0
textbox.actual = 1
textbox.message = ""
textbox.textpos = 1

function textbox:createDialogue(msgInitial, msgFinal)
	self.inicio = msgInitial
	self.fim = msgFinal
	self.active = true
	self.textpos = 1
	self.time = 0
	screenmanager.currentScreen.dialogue = true
	self.actual = msgInitial
end

function textbox:update(dt)
	if self.active then
		self.time = self.time + 0.4
		if self.textpos <= self[self.language][self.actual].text:len()  and self.time > 1 then
			self.time = 0
			self.message = self[self.language][self.actual].text:sub(1,self.textpos)
			self.textpos = self.textpos + 1
		end
	end
end

function textbox:next()
	if self.textpos < self[self.language][self.actual].text:len() then
		self.textpos = self[self.language][self.actual].text:len()
	else
		if self.actual >= self.fim then
			self.active = false
			screenmanager.currentScreen.dialogue = false
		end
		self.textpos = 1
		self.time = 0
		self.actual = self.actual + 1
	end
end

function textbox:draw()
	love.graphics.setColor(0,0,0,125)
	love.graphics.rectangle("fill",math.abs(camera.x),math.abs(camera.y),global.width, 48)
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(self.image, self.portraits[self[self.language][self.actual].image], 2+math.abs(camera.x),4+math.abs(camera.y))
	love.graphics.printf(self.message,28+ math.abs(camera.x),1+math.abs(camera.y),100)
	--print(self.message)
end