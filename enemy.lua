enemies = {}
enemy = {}

function enemy.load()
    limit = game.roomWidth/32-1
    j = 0
    for i = 10, limit do
        j = love.math.random(10)
        if j == 5 then
            newEnemy = {x = i*32,y = 320,width = 32,height = 32,yvel = 600}
            table.insert(enemies,newEnemy)
        end
    end
end

function enemy.update(dt)
    for i,en in ipairs(enemies) do
        if en.y + (en.yvel*dt) < love.graphics:getHeight()-(32+en.height) then
            en.yvel = en.yvel + (gravity*dt) 
            en.y = en.y + (en.yvel*dt)
            for i,block in ipairs(blocks) do
                if checkCol(en.x,en.y+(en.y*dt),en.width,en.height,block.x,block.y,block.width,block.height) then
                        en.yvel = 0
                        en.y = block.y - en.height
                        break
                end
            end
        end
    end
end

function enemy.draw()
    love.graphics.setColor(255,0,0)
    love.graphics.print(table.getn(enemies),0,0)
    for i,en in ipairs(enemies) do
        love.graphics.rectangle("line",en.x,en.y,en.width,en.height)
    end
end