enemies = {}
enemy = {}

function enemy.load()
    limit = game.roomWidth/32-1
    j = 0
    while table.getn(enemies) < 10 do
        j = love.math.random(game.windowWidth,game.roomWidth)
        newEnemy = {x = j,y = 320,width = 32,height = 32,yvel = 600,xvel = 0}
        table.insert(enemies,newEnemy)
    end
end

function enemy.update(dt)
    while table.getn(enemies) < 20 do
        j = love.math.random(10,game.roomWidth/32)
        newEnemy = {x = j*32,y = 320,width = 32,height = 32,yvel = 600, xvel = 0}
        table.insert(enemies,newEnemy)
    end
    for i,en in ipairs(enemies) do
        --if en.y + (en.yvel*dt) < love.graphics:getHeight()-32-en.height then
            en.yvel = en.yvel + (gravity*dt) 
            en.y = en.y + (en.yvel*dt)
            for j,block in ipairs(blocks) do
                if checkCol(en.x,en.y+(en.y*dt),en.width,en.height,block.x,block.y,block.width,block.height) then
                        en.yvel = 0
                        en.y = block.y - en.height
                        break
                end
            end
        --end
        if math.sqrt((en.x-player.x)^2+(en.y-player.y)^2) < 240 then
            en.xvel = (player.x-en.x)*dt
            en.x = en.x + en.xvel
        end
    end
end

function enemy.draw()
    love.graphics.setColor(255,255,0)
    love.graphics.print(table.getn(enemies),0,0)
    for i,en in ipairs(enemies) do
        love.graphics.rectangle("line",en.x,en.y,en.width,en.height)
    end
end