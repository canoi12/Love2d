enemies = {}
enemy = {}

function enemy.load()
    enemy.speed = 250
end

function enemy.update(dt)
    while table.getn(enemies) < 20 do
        newEnemy = {x = math.random(game.roomWidth), y = math.random(game.roomHeight),width = 32, height = 32}
        table.insert(enemies,newEnemy)
    end
    
end

function enemy.draw()
    for i,e in ipairs(enemies) do
        love.graphics.rectangle("line",e.x,e.y,e.width,e.height)
    end
end