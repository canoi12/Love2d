gameobject={}

gameobject.x=0
gameobject.y=64
gameobject.dx=0
gameobject.dy=0
gameobject.friction=0.75
gameobject.bounce=0.0
gameobject.image=nil
gameobject.anim={}
gameobject.frame=1
gameobject.actualAnim=""
gameobject.animTime=0
gameobject.xscale=1
gameobject.yscale=1
gameobject.orx=0
gameobject.ory=0

function gameobject:new(o)
	local o = o or {}
	return setmetatable(o, {__index=self})
end

function gameobject:createAnim(name,x,y,numImg,frmWid,frmHei)
	local anima={}
	self.anim[name]={}
	xFrm = x/frmWid
	for i=(xFrm),(xFrm + numImg)-1 do
		table.insert(self.anim[name],love.graphics.newQuad(i*frmWid,y,frmWid, frmHei, self.image:getDimensions()))
	end
end

function gameobject:playAnim(name)
	if self.actualAnim ~= name then
		self.frame=1
		self.actualAnim=name
	end
end

function gameobject:update(dt)

end

function gameobject:draw()
end