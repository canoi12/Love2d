player = {}

function player.load()
    player.x = 0
    player.y = 0
    player.Image = love.graphics.newImage("assets/square.png")
    player.width = player.Image:getWidth()
    player.height = player.Image:getHeight()
    player.speed = 250
    player.angle = 0
    
    player.dx = 0
    player.dy = 0

end

function player.update(dt)
    if love.keyboard.isDown("left") then
        player.angle = player.angle - 0.05
    end
    
    if love.keyboard.isDown("right") then
        player.angle = player.angle + 0.05
    end
    
    player.dx = player.speed * math.cos(player.angle)
    player.dy = player.speed * math.sin(player.angle)
    
    if love.keyboard.isDown("up") then
        player.x = player.x + (player.dx*dt)
        player.y = player.y + (player.dy*dt)
    end
    
    player.x = Clamp(player.x,0+player.width/2,game.roomWidth-(player.width/2))
    player.y = Clamp(player.y,0+player.height/2,game.roomHeight-(player.height/2))
end

function player.draw()
    love.graphics.draw(player.Image,player.x,player.y,player.angle,1,1,player.width/2,player.height/2)
end