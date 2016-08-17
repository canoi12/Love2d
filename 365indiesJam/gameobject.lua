gameobject={}

gameobject.x=0 --posição x do objeto
gameobject.y=0 --posição y do objeto
gameobject.width=16 --largura do objeto
gameobject.height=16 --altura do objeto
gameobject.dx=0 --variação da posição x
gameobject.dy=0 --variação da posição y

gameobject.xinitial=0
gameobject.yinitial=0

gameobject.friction = 0.75
gameobject.bounce = 0
gameobject.gravity=0.2 --gravidade
gameobject.xscale=1 --valor da escala do x
gameobject.yscale=1 --valor da escala do y
gameobject.xorigin=8 --valor da origem do eixo x
gameobject.yorigin=8 --valor da origem do eixo y
gameobject.image=nil --imagem
gameobject.anim={} --tabela contendo as animações
gameobject.frame=1 --frame atual
gameobject.animTime=0 --tempo para trocar de frame
gameobject.animSpeed=0.15
gameobject.actualAnim="" --animação atual
gameobject.kind=0
gameobject.flip=1
gameobject.angle=0
gameobject.type=""
gameobject.damage=false
gameobject.damageTime=1
gameobject.destroy = false
gameobject.life = 5

gameobject.knockback=8

gameobject.quadrant = 0

gameobject.bbox = {
	left = 0,
	right = 16,
	top = 0,
	bottom= 16
}

gameobject.isGround = false

function gameobject:collision(table)

end

function gameobject:new(o)
	o = o or {}
	return setmetatable(o, {__index=self})
end

function gameobject:addAnim(name,x,y,frmWid,frmHei,numImages)
	--local anim = {}
	self.anim[name] = {}
	xFrm = x / frmWid
	for i=xFrm,(xFrm+numImages) do
		table.insert(self.anim[name],love.graphics.newQuad(i*frmWid,y,frmWid,frmHei,self.image:getDimensions()))	
	end
	if self.actualAnim == "" then
		self.actualAnim = name
	end
end

function gameobject:setAnim(name)
	if self.actualAnim ~= name then
		self.actualAnim = name
		self.frame = 1
	end
end

function gameobject:playAnim()
	if self.animTime >= 1 then
		self.animTime = 0
		self.frame =  self.frame + 1
	else
		self.animTime = self.animTime + self.animSpeed
	end

	if self.frame >= table.getn(self.anim[self.actualAnim]) then
		self.frame = 1
	end
end

function gameobject:load()

end

function gameobject:update(dt)

end

function gameobject:draw()
end

function gameobject:keypressed(key)

end