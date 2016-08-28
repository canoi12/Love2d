require "vector3"

p0 = vector3:new{x=50,y=200}
p1 = vector3:new{x=100,y=50}
p2 = vector3:new{x=400, y=500}
p3 = vector3:new{x=500,y=200}
p4 = vector3:new{x=600,y=250}
p5 = vector3:new{x=650,y=250}
p6 = vector3:new{x=675, y=250}

local point = -1

function distance(x1,y1,x2,y2)
    local dx = x2 - x1
    local dy = y2 - y1
    
    return math.sqrt((dx*dx)+(dy*dy))
end

function calculateBezierPoint(t, p0, p1, p2, p3)
    local u = 1 - t
    local tt = t*t
    local uu = u*u
    local uuu = uu*u
    local ttt = tt*t
    
    p = p0:mul(uuu)
    aux = p1:mul(3 * uu * t)
   	p = p:sumV3(aux)
    aux = p2:mul(3 * u * tt)
    p = p:sumV3(aux)
    aux = p3:mul(ttt)
    p = p:sumV3(aux)

    return p
end

function love.load()
    j = 1
end

function love.update(dt)
    local x = love.mouse.getX()
    local y = love.mouse.getY()


    if love.mouse.isDown(1) then
        if distance(x,y,p0.x,p0.y) <= 12 then
            point = 0
        elseif distance(x,y,p1.x,p1.y) <= 12 then
            point = 1
        elseif distance(x,y,p2.x,p2.y) <= 12 then
            point = 2
        elseif distance(x,y,p3.x,p3.y) <= 12 then
            point = 3
        elseif distance(x,y,p4.x,p4.y) <= 12 then
            point = 4
        elseif distance(x,y,p5.x,p5.y) <= 12 then
            point = 5
        elseif distance(x,y,p6.x,p6.y) <= 12 then
            point = 6
        end
    else
        point = -1 
    end

    if point == 0 then
        p0.x = x
        p0.y = y
    elseif point == 1 then
        p1.x = x
        p1.y = y
    elseif point == 2 then
        p2.x = x
        p2.y = y
    elseif point == 3 then
        p3.x = x
        p3.y = y
    elseif point == 4 then
        p4.x = x
        p4.y = y
    elseif point == 5 then
        p5.x = x
        p5.y = y
    elseif point == 6 then
        p6.x = x
        p6.y = y
    end

end

function love.draw()
    q0 = calculateBezierPoint(0, p0, p1, p2, p3);

    --[[for i = 1, 50 do
        t = i / 50
        q1 = calculateBezierPoint(t, p0,p1,p2,p3)
        love.graphics.circle("fill",p0.x,p0.y,12)
        love.graphics.circle("fill",p1.x,p1.y,12)
        love.graphics.circle("fill",p2.x,p2.y,12)
        love.graphics.circle("fill",p3.x,p3.y,12)
        love.graphics.line(q0.x,q0.y,q1.x,q1.y)
        love.graphics.circle("line",q1.x,q1.y,8)
        q0 = q1
    end]]
    for i = 1, 50 do
        t = i / 50
        q1 = calculateBezierPoint(t, p0,p1,p2,p3)
        love.graphics.circle("fill",p0.x,p0.y,12)
        love.graphics.circle("fill",p1.x,p1.y,12)
        love.graphics.circle("fill",p2.x,p2.y,12)
        love.graphics.circle("fill",p3.x,p3.y,12)
        love.graphics.line(q0.x,q0.y,q1.x,q1.y)
        q0 = q1
        --q1 = q2
    end
    q0 = calculateBezierPoint(0, p3, p4, p5, p6);
    for i = 1, 50 do
        t = i / 50
        q1 = calculateBezierPoint(t, p3, p4, p5, p6)
        love.graphics.circle("fill",p3.x,p3.y,12)
        love.graphics.circle("fill",p4.x,p4.y,12)
        love.graphics.circle("fill",p5.x,p5.y,12)
        love.graphics.circle("fill",p6.x,p6.y,12)
        love.graphics.line(q0.x,q0.y,q1.x,q1.y)
        q0 = q1
        --q1 = q2
    end

    --[[]]
    t = (math.sin(j)*50+50) / 100
    q1 = calculateBezierPoint(t, p0,p1,p2,p3)

    love.graphics.circle("line",q1.x,q1.y,8)
    q0 = q1

    j = j + 0.02
    if j % (math.pi*2) == 0 then
        j = 0
    end

end