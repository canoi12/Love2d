bullets = {}
bullet = {}

function bullet.load()
    bulletSpeed = 300
    
    local img = love.graphics.newImage("assets/circle.png")
    
    bullet.psystem = love.graphics.newParticleSystem(img,32)
    
    bullet.psystem:setParticleLifetime(2,5)
    bullet.psystem:setEmissionRate(5)
    bullet.psystem:setSizeVariation(1)
    bullet.psystem:setLinearAcceleration(10,10,12,12)
    bullet.psystem:setColors(255,255,255,255,255,255,255,0)
    bullet.psystem:setSpeed(2,3)
end

function bullet.update(dt)
    for i,b in ipairs(bullets) do
        b.x = b.x + (b.dx*dt)
        b.y = b.y + (b.dy*dt)
    end
end

function bullet.draw()
    for i,b in ipairs(bullets) do
        love.graphics.circle("line",b.x,b.y,6)
        if b.x > camera.x + game.windowWidth or b.x < camera.x or
            b.y > camera.y + game.windowHeight or b.y < camera.y then
            table.remove(bullets,i)     
       end
       
       for j,e in ipairs(enemies) do
            if b.x > e.x and b.x < e.x+e.width and
                b.y > e.y and b.y < e.y + e.height then
                table.remove(enemies,j)  
                table.remove(bullets,i)  
            end
       end
    end
end

function bullet.keypressed(key)

    if key == "up" or key == "down" or
       key == "left" or key == "right" then
        local startX = player.x
        local startY = player.y
        
        local angle = player.angle
        
        local bulletDx = bulletSpeed * math.cos(angle)
        local bulletDy = bulletSpeed * math.sin(angle)
        
        table.insert(bullets,{x = startX,y = startY,dx = bulletDx, dy = bulletDy})
    end
end