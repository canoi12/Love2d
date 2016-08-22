textbox = {}

local utf8 = require("utf8")

textbox = {
	["pt"] = {
		[1] = {
			image = 2,
			text ="Olá, jovem guerreiro."
		},
		[2] = {
			image = 1,
			text = "Quem é você?"
		},
		[3] = {
			image = 2,
			text = "Me desculpe, sou o guardião desta dimensão."
		},
		[4] = {
			image = 1,
			text = "Desta dimensão?! O que quer dizer?"
		},
		[5] = {
			image = 2,
			text = "Sim, você está em outra dimensão, para ser mais exato estamos na dimensão 45."
		},
		[6] = {
			image = 1,
			text = "Mas então o que estou fazendo aqui?"
		},
		[7] = {
			image = 2,
			text = "Bom, eu te trouxe pra cá."
		},
		[8] = {
			image = 1,
			text = "O que? Como assim?"
		},
		[9] = {
			image = 2,
			text = "Bom, um tempo atrás, um objeto misterioso veio parar aqui nesta dimensão."
		},
		[10] = {
			image = 2,
			text = "Isso gerou algum tipo de incoerência nesse mundo, trazendo criaturas de outras realidades para cá."
		},
		[11] = {
			image = 2,
			text = "E eu não sei os efeitos que isso pode gerar se ele continuar aqui, pode ate apagar esta realidade."
		},
		[12] = {
			image = 2,
			text = "No seu mundo você e um herói, por isso eu te trouxe. Eu te suplico, por favor, salve este mundo."
		},
		[13] = {
			image = 1,
			text = "Mas por que eu? Com tantos universos devem haver outros heróis por aí."
		},
		[14] = {
			image = 2,
			text = "Bem, o Goku estava ocupado salvando a terra mais uma vez..."
		},
		[15] = {
			image = 1,
			text = "-.-'... Já que é assim, por mim tá tudo bem. Eu vou salvar seu mundo!"
		},
		[16] = {
			image = 2,
			text = "Muito obrigado, guerreiro. Boa sorte na sua jornada."
		},
		[17] = {
			image = 1,
			text = "Então esse é o objeto?"
		},
		[18] = {
			image = 1,
			text = "Vai ser bem fácil me livrar dele."
		},
		[19] = {
			image = 3,
			text = "Como assim, irmão? Acha que vou me entregar facilmente? Muahahaha"
		},
		[20] = {
			image = 1,
			text = "O queee?! o.o"
		},
		[21] = {
			image = 3,
			text = "Como eu pude ter sido derrotado?! Isso vai ter volta!"
		},
		[22] = {
			image = 3,
			text = "Guarde bem minhas palavras, guerreiro. Eu me vingarei!"
		},
		[23] = {
			image = 3,
			text = "Aaaaaaah!!"
		},
		[24] = {
			image = 1,
			text = "Ufa, parece que finalmente tudo acabou."
		},
		[25] = {
			image = 2,
			text = "Sim, parece que está tudo se estabilizando."
		},
		[26] = {
			image = 2,
			text = "Algumas criaturas ainda se recusam a voltar a seus mundos."
		},
		[27] = {
			image = 2,
			text = "Mas uma hora ou outra elas devem retornar."
		},
		[28] = {
			image = 1,
			text = "Entendo. Bom, se é assim, acho que meu trabalho chegou ao fim."
		},
		[29] = {
			image = 2,
			text = "Sim, e eu tenho uma dívida eterna com você. Muito obrigado."
		},
		[30] = {
			image = 1,
			text = "De nada. Hora de voltar ao meu mundo..."
		}
	},
	["en"] = {
		[1] = {
			image = 2,
			text ="Hi, young warrior."
		},
		[2] = {
			image = 1,
			text = "Who are you?"
		},
		[3] = {
			image = 2,
			text = "Sorry, i'm the guardian of this dimension."
		},
		[4] = {
			image = 1,
			text = "This dimension?! What you mean?"
		},
		[5] = {
			image = 2,
			text = "Yes, you are in other dimension, to be exact, we are on dimension 45."
		},
		[6] = {
			image = 1,
			text = "So, what am i doing here?"
		},
		[7] = {
			image = 2,
			text = "Well, i brought you."
		},
		[8] = {
			image = 1,
			text = "What? Why?"
		},
		[9] = {
			image = 2,
			text = "Well, some time ago, a mysterious object came here for this dimension."
		},
		[10] = {
			image = 2,
			text = "This generated some kind of incoherence in this world, bringing creatures of other realities."
		},
		[11] = {
			image = 2,
			text = "And i don't know the effects that it can cause if it stay here. It can even destroy this universe."
		},
		[12] = {
			image = 2,
			text = "In your world, you're a hero, that's why i brought you. I beg you, please, save this world."
		},
		[13] = {
			image = 1,
			text = "But, why me? With so many universes, must be other heros."
		},
		[14] = {
			image = 2,
			text = "Well, Goku was busy saving the earth one more time..."
		},
		[15] = {
			image = 1,
			text = "-.-'... Since it's so, for me is okay. I will save your world!"
		},
		[16] = {
			image = 2,
			text = "Thank you, warrior. Good luck in your journey."
		},
		[17] = {
			image = 1,
			text = "So, this is the object?"
		},
		[18] = {
			image = 1,
			text = "Will be very easy destroy it."
		},
		[19] = {
			image = 3,
			text = "What you mean, bro? Are you thinking that will destroy me easily? Muahahaha"
		},
		[20] = {
			image = 1,
			text = "Whaaat?! o.o"
		},
		[21] = {
			image = 3,
			text = "How could i be defeated?!"
		},
		[22] = {
			image = 3,
			text = "Save my words, warrior. I will take revenge!"
		},
		[23] = {
			image = 3,
			text = "Aaaaaaah!!"
		},
		[24] = {
			image = 1,
			text = "Ugh, it seens finally over."
		},
		[25] = {
			image = 2,
			text = "Yes, seens all is stabilizing."
		},
		[26] = {
			image = 2,
			text = "Some creatures refuse to come back to your worlds."
		},
		[27] = {
			image = 2,
			text = "But some time it will back."
		},
		[28] = {
			image = 1,
			text = "I see. Well, i think my work came to an end."
		},
		[29] = {
			image = 2,
			text = "Yes, and i have an eternal debt with you. Thank you."
		},
		[30] = {
			image = 1,
			text = "You're welcome. It's time to back to my world..."
		}
	}
}

textbox.image = love.graphics.newImage("Assets/portraits.png")

textbox.portraits = {
	[1] = love.graphics.newQuad(0,0,24,24,textbox.image:getDimensions()),
	[2] = love.graphics.newQuad(24,0,24,24,textbox.image:getDimensions()),
	[3] = love.graphics.newQuad(48,0,24,24,textbox.image:getDimensions())
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
	self.language = global.language
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
		if self.textpos <= self[global.language][self.actual].text:len()  and self.time > 1 then
			self.time = 0
			self.message = self.message .. utils.utf8sub(self[global.language][self.actual].text,self.textpos,1)
			--print(self.message:sub(self.textpos,self.textpos))
			--print(self.message)
			--print(type(self.message), self.message)
			--print(string.byte(self.message, self.textpos, self.textpos))
			--print(utf8.char(string.byte(self.message, self.textpos, self.textpos)))
			--print(self[self.language][self.actual].text)
			--print(string.byte(self.message, 3, 3))
			--print(self.message)
			--local byteoffset = utf8.offset(self.message,-1)
			--self.message = utils.utf8sub(self[global.language][self.actual].text,self.textpos,self.textpos)
			--print(self.message)
			--string.gsub()
			self.textpos = self.textpos + 1
		end
	end
end

function textbox:next()
	if self.textpos < self[global.language][self.actual].text:len() then
		self.textpos = self[global.language][self.actual].text:len()
		self.message = self[global.language][self.actual].text
	else
		if self.actual >= self.fim then
			self.active = false
			screenmanager.currentScreen.dialogue = false
			if global.finalBossDialogue then
				global.finalFinalCutscene = true
			end
			if global.finalFinalCutscene and global.finalFinalCutsceneStart then
				global.finalFinalCutsceneEnd = true
			end
		end
		self.textpos = 1
		self.time = 0
		self.actual = self.actual + 1
		self.message = ""
	end
end

function textbox:draw()
	love.graphics.setColor(0,0,0,175)
	love.graphics.rectangle("fill",math.abs(camera.x),math.abs(camera.y),global.width, 48)
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(self.image, self.portraits[self[self.language][self.actual].image], 2+math.abs(camera.x),4+math.abs(camera.y))
	love.graphics.printf(self.message,28+ math.abs(camera.x),1+math.abs(camera.y),100)
	--print(self.message)
end