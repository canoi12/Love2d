block = gameobject:new() -- Meta tabela para cada bloco
blocks = {} -- Meta tabela que guardará todos os blocos
-- Atributos da classe
block.x = 128
block.width = 64
block.height = 64
block.y = love.graphics:getHeight()-block.height
block.i = 0

-- Métodos da classe bloco

function block:new(x,y,width,height)
	o = {x=x,width=width,height=height,y=y,type='block'} or {}
	return setmetatable(o,{__index = self})
end

function block:setPosition(x,y)
	self.x = x
	self.y = y
end

function block:setSize(width,height)
	self.width = width
	self.height = height
end

function block:getPosition()
	return self.x, self.y
end

function block:getSize()
	return self.width, self.height
end

function block:load()
end

function block:update(dt)
	
end

function block:draw()
	if self.ativo then
		love.graphics.circle("fill",self.x,self.y,12)
		love.graphics.circle("fill",self.x+self.width,self.y+self.height,12)
	end
	love.graphics.rectangle("line",self.x,self.y,self.width,self.height)
end

return blocks