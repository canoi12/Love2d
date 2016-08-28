triang = {}

triang.p0 = vector2:new()
triang.p1 = vector2:new()
triang.p2 = vector2:new()
triang.p3 = vector2:new()

triang.table = {0,0,0,0,0,0,0,0}


function triang:new(x1,y1,x2,y2,x3,y3,x4,y4)
    local o = {
        p0 = vector2:new{x=x1,y=y1},
        p1 = vector2:new{x=x2,y=y2},
        p2 = vector2:new{x=x3,y=y3},
        p3 = vector2:new{x=x4,y=y4},
        table = {
            x1, y1,
            x2, y2,
            x3, y3,
            x4, y4
        }
    }
    return setmetatable(o, {__index = self})
end

function triang:draw()
    love.graphics.polygon("fill", self.table)
    vl1 = self.p1:sub(self.p0)
    vl2 = self.p2:sub(self.p1)
    vl3 = self.p3:sub(self.p2)
    vl4 = self.p0:sub(self.p3)


    vo1 = vl1:orto()
    vo2 = vl2:orto()
    vo3 = vl3:orto()
    vo4 = vl4:orto()

    love.graphics.line(vl1.x, vl1.y, vl2.x, vl2.y, vl3.x, vl3.y, vl4.x, vl4.y)

    love.graphics.line(vo1.x, vo1.y, vo2.x, vo2.y, vo3.x, vo3.y, vo4.x, vo4.y)
end

function triang:isInside(x, y)
    --[[local vl1 = vector2:new()
    local vl2 = vector2:new()
    local vl3 = vector2:new()]]

    vl1 = self.p1:sub(self.p0)
    vl2 = self.p2:sub(self.p1)
    vl3 = self.p3:sub(self.p2)
    vl4 = self.p0:sub(self.p3)

    vo1 = vl1:orto()
    vo2 = vl2:orto()
    vo3 = vl3:orto()
    vo4 = vl4:orto()

    p = vector2:new{x = x, y = y}
    vp1 = self.p0:sub(p)
    vp2 = self.p1:sub(p)
    vp3 = self.p2:sub(p)
    vp4 = self.p3:sub(p)

    return (sign(vp1:dot(vo1)) == sign(vp2:dot(vo2)) and sign(vp2:dot(vo2)) == sign(vp3:dot(vo3)) and sign(vp3:dot(vo3)) == sign(vp4:dot(vo4)) )
end