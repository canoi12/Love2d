require("player")

function math.clamp(v1,v2,v3)
    if v1 < v2 then
        return v2
    end
    if v1 > v3 then
        return v3
    end
    
    return v1
end

function love.load()
    player.load()
    gravity = 2000
end

function player.checkCol(x1,y1,w1,h1,x2,y2,w2,h2)
    if x1 < x2 + w2 and
       x1 + w1 > x2 and
       y1 < y2 + h2 and
       y1 + h1 > y2 then
        return true
    end
end

function love.update(dt)
    player.update(dt)
end

function love.draw()
    player.draw()
end

function love.keypressed(k)
    if k == "escape" then
        love.event.quit()
    end
    player.keypress(k)
end