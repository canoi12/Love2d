swordcol=gameobject:new({anim={}})


function swordcol:load()
	self.bbox = {
		left = 0,
		right = 16,
		top = 0,
		bottom = 16
	}
	self.xorigin = 16
	self.yorigin = 16
	self.kind = 3
end

function swordcol:update(dt)

end

function swordcol:draw()
	--love.graphics.rectangle("line",self.x+self.bbox.left-self.xorigin,self.y+self.bbox.top-self.yorigin, self.bbox.right,self.bbox.bottom)
end