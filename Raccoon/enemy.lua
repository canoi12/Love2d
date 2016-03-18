enemies = {}
enemy = {}

function enemy.load()
    enemy.speed = 250
    enemy.image = love.graphics.newImage("assets/square.png")
end

function enemy.update(dt)
    while table.getn(enemies) < 20 do
        newEnemy = {x = math.random(game.roomWidth-32), y = math.random(game.roomHeight-32),width = 32, height = 32}
        table.insert(enemies,newEnemy)
    end
    for i, e in ipairs(enemies) do
        local angle = math.atan2(e.y-love.mouse.getY()-camera.y,e.x-love.mouse.getX()-camera.x)+1.3
        e.angle = angle
    end
    
end

function enemy.draw()
    for i,e in ipairs(enemies) do
        love.graphics.draw(enemy.image,e.x,e.y,0,1,1,16,16)
    end
end