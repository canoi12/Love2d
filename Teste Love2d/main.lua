player = {}
enemies = {}
bullets = {}
game = {}
game.roomWidth = 640
game.roomHeight = 480

function math.clamp(valor1,valor2,valor3)
    if valor1 < valor2 then
        return valor2
    end
    if valor1 > valor3 then
        return valor3
    end
    return valor1
end

function distance(xa,ya,xb,yb)
    return math.sqrt((xa-xb)^2 + (ya-yb)^2)
end

function bool_to_int(valor)
    if valor == true then
        return 1
    end
    return 0
end

function love.load()
    player.x = 0
    player.y = 0
    player.width = 32
    player.height = 32
    player.speed = 400
    player.img = love.graphics.newImage("assets/charteste.png")
    
    
    game.background = love.graphics.newImage("assets/background.png")
    game.background:setWrap("repeat","repeat")
    
    game.bgquad = love.graphics.newQuad(0,0,game.roomWidth,game.roomHeight,game.background:getDimensions())
    
    
    bulletSpeed = 250
end

function love.update(dt)
    moveH = bool_to_int(love.keyboard.isDown("d")) - bool_to_int(love.keyboard.isDown("a"))
    
    player.x = player.x+((player.speed*moveH)*dt)
    
    moveV = bool_to_int(love.keyboard.isDown("s")) - bool_to_int(love.keyboard.isDown("w"))
    
    player.y = player.y+((player.speed*moveV)*dt)
    while table.getn(enemies) < 10 do
        newEnemy = {x = math.random(game.roomWidth),y = math.random(game.roomHeight),xvel = 0,yvel = 0,width = 32, height = 32}
        table.insert(enemies,newEnemy)
    end
	for i,v in ipairs(bullets) do
        v.x = v.x + (v.dx * dt)
        v.y = v.y + (v.dy * dt)
        if v.x > love.graphics:getWidth() or
            v.x < 0 or
            v.y > love.graphics:getHeight() or
            v.y < 0 then
            table.remove(bullets,i);
        end
        for j, e in ipairs(enemies) do
            if v.x > e.x and v.x < e.x + e.width and
                v.y > e.y and v.y < e.y + e.height then
                table.remove(enemies,j)
                table.remove(bullets,i)  
            end
        end
    end
    
    for i, e in ipairs(enemies) do
        if distance(player.x,player.y,e.x,e.y) < 240 then
            e.xvel = (player.x-e.x)*dt
            e.x = e.x+e.xvel
            e.yvel = (player.y-e.y)*dt
            e.y = e.y+e.yvel
        end
    end
    
    player.x = math.clamp(player.x,0,love.graphics:getWidth()-32)
    player.y = math.clamp(player.y,0,love.graphics:getHeight()-32)
    dist1 = distance(player.x,player.y,love.mouse:getX(),love.mouse:getY())
    --dist2 = distance(enemy.x,enemy.y,player.x,enemy.y)
    --dist3 = distance(player.x,player.y,player.x,enemy.y)
    dist2 = love.mouse:getY() - player.y
    dist3 = love.mouse:getX() - player.x
    --[[senA = dist2/dist1
    cosA = dist3/dist1 
    teste = dist2/dist3
    artan = 1/teste--]]
end

function love.draw()
    love.graphics.setColor(255,255,255)
    love.graphics.draw(game.background,game.bgquad,0,0)
    love.graphics.setColor(255,255,255)
    --love.graphics.rectangle("line",player.x,player.y,player.width,player.height)
    love.graphics.draw(player.img,player.x,player.y,math.atan2(player.y-love.mouse.getY(),player.x-love.mouse.getX()), 1,1,16,16)
    --love.graphics.print(math.abs((dist2/dist1*360)*math.pi/180),0,0)
    love.graphics.print(table.getn(bullets),0,0)
    love.graphics.setColor(255,0,0)
    for i, e in ipairs(enemies) do
        love.graphics.rectangle("line",e.x,e.y,e.width,e.height)
    end
    love.graphics.line(player.x,player.y,love.mouse:getX(),love.mouse:getY())
	for i,bul in ipairs(bullets) do
		love.graphics.circle("fill",bul.x,bul.y,3)
	end
end

function love.mousepressed(x,y,button)
    if button == 1 then
        local startX = player.x
        local startY = player.y
        local mouseX = x
        local mouseY = y
        
        local angle = math.atan2(mouseY-startY,mouseX-startX)
        
        local bulletDx = bulletSpeed * math.cos(angle)
        local bulletDy = bulletSpeed * math.sin(angle)
        
        table.insert(bullets,{x = startX,y = startY, dx = bulletDx, dy = bulletDy})
    end
end
