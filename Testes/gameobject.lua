gameobject = {}

gameobject.x = 0
gameobject.y = 0
gameobject.dx = 0
gameobject.dy = 0
gameobject.grav = 0.2
gameobject.anim ={}
gameobject.animTime=0
gameobject.actualAnim="idle"
gameobject.teste={}
gameobject.frame = 1
gameobject.image=nil



function gameobject:new(o)
	o = o or {}
	self:load()
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

function gameobject:playAnim()
	if self.animTime >= 1 then
		self.animTime = 0
		self.frame =  self.frame + 1
	else
		self.animTime = self.animTime + 0.15
	end

	if self.frame >= table.getn(self.anim[self.actualAnim]) then
		self.frame = 1
	end
end

function gameobject:move(x)
	self.dx = x
end

function gameobject:load()
end

function gameobject:update(dt)
	if self.y < 480 then
		self.dy = self.dy + self.grav
	else
		self.dy = 0
		self.y = 480
	end

	self.y = self.y + self.dy
end

function gameobject:draw()
end