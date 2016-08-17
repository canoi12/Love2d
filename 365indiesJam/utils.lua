utils={}
function utils.sign(x)
	if x > -0.5 and x < 0.5 then
		return 0
	end
	if x < 0 then
		return -1
	elseif x > 0 then
		return 1
	end
	return 0
end

-- check if a position on the grid is solid
function utils.check_solid(x,y)
	if x < 0 or x > (screenmanager.currentScreen.map.test.width)*screenmanager.currentScreen.tilewidth or 
	   y < 0 or y > (screenmanager.currentScreen.map.test.height)*screenmanager.currentScreen.tileheight then
		return false
	end
	local test = true
	for i,v in ipairs(screenmanager.currentScreen.map.test.tilesets[1].tiles) do
		if screenmanager.currentScreen.map.tmap[math.floor((y)/screenmanager.currentScreen.tileheight)][math.floor((x)/screenmanager.currentScreen.tilewidth)] == v.id+1 and v.properties["solid"]==1 then
			return true
		end
	end
	return false
end

function utils.check_through(x,y)
	if x < 0 or x > (screenmanager.currentScreen.map.test.width)*screenmanager.currentScreen.tilewidth or 
	   y < 0 or y > (screenmanager.currentScreen.map.test.height)*screenmanager.currentScreen.tileheight then
		return false
	end
	local test = true
	for i,v in ipairs(screenmanager.currentScreen.map.test.tilesets[1].tiles) do
		if screenmanager.currentScreen.map.tmap[math.floor((y)/screenmanager.currentScreen.tileheight)][math.floor((x)/screenmanager.currentScreen.tilewidth)] == v.id+1 and v.properties["solid"]==2 then
			return true
		end
	end
	return false
end

function utils.approach(v1,v2,variation)
	if v1 < (v2 + 0.001) and v1 > (v2 - 0.001) then
		return v2
	end

	if v1 < v2 then
		v1 = v1 + variation
	elseif v1 > (v2) then
		v1 = v1 - variation
	end

	return v1
end

function utils.distanceToPoint(x1,y1,x2,y2)
	local dx = x2 - x1
	local dy = y2 - y1

	return math.sqrt((dx*dx)+(dy*dy))
end

function utils.cameraBound()
	--camera.x = math.min(0,math.max(camera.x,-(screenmanager.currentScreen.map.test.width*16)+128))
	--camera.y = math.min(0,math.max(camera.y,-(screenmanager.currentScreen.map.test.height*16)+128))

	camera.x = -global.width*math.floor(screenmanager.currentScreen.objects[1].x/global.width)
	camera.y = -global.height*math.floor(screenmanager.currentScreen.objects[1].y/global.height)
end

function utils.collision(obj1, obj2)
	if obj1 == obj2 or obj1.kind == obj2.kind then
		return false
	end
	local ob1 = {
		x = obj1.bbox.left + obj1.x - obj1.xorigin,
		y = obj1.bbox.top + obj1.y - obj1.yorigin,
		w = obj1.bbox.right - obj1.bbox.left,
		h = obj1.bbox.bottom - obj1.bbox.top,
		flip = obj1.flip
	}
	if obj1.flip == -1 and obj1.kind == 3 then
		ob1.xc = (ob1.x-12) + (ob1.w/2)
	else
		ob1.xc = (ob1.x) + (ob1.w/2)
	end
	ob1.yc = ob1.y + (ob1.h/2)
	local ob2 = {
		x = obj2.bbox.left + obj2.x - obj2.xorigin,
		y = obj2.bbox.top + obj2.y - obj2.yorigin,
		w = obj2.bbox.right - obj2.bbox.left,
		h = obj2.bbox.bottom - obj2.bbox.top,
		flip = obj2.flip
	}

	if obj2.flip == -1 and obj2.kind == 3 then
		ob2.xc = (ob2.x-12) + (ob2.w/2)
	else
		ob2.xc = (ob2.x) + (ob2.w/2)
	end
	ob2.yc = ob2.y + (ob2.h/2)

	local w = (ob1.w + ob2.w)/2
	local h = (ob1.h + ob2.h)/2

	local dx = ob1.xc - ob2.xc
	local dy = ob1.yc - ob2.yc

	if math.abs(dx) <= w and math.abs(dy) <= h then
		local wy = y * dy
		local hx = h * dx

		if obj1.kind == 3 or obj2.kind == 3 then
			return true
		end

		if wy > hx then
			if wy > -hx then
				obj1.y = obj2.y + h
			else
				obj1.x = obj2.x - w
			end
		else
			if wy > -hx then
				obj1.x = obj2.x + w
			else
				obj1.y = obj2.y - h
			end
		end
		return true
	end
	return false

	--[[if ob1.x + ob1.w > ob2.x and ob1.x < ob2.x + ob2.w and
		ob1.y + ob1.h > ob2.y and ob1.y < ob2.y + ob2.h then
		return true
	end
	return false]]


end