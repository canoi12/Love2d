local func = {}

function func:coll4side(ob1,obj2)
	-- body
end

function func:addAnimation(name,x,y,width,height,imgW,imgH)
	[name] = {}
	v = imgW/width
	for i=0,v do
		[name].[i] = love.graphics.newQuad(i*width,y,width,height,imgW,imgH)
	end
	return [name]
end

return func