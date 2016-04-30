bullets = {}
bullet = {}

function bullet.load()

end

function bullet.update(dt)
    if love.keyboard.isDown("z") then
        newBullet = {x = player.x, y = player.y, dx = player.dx, dy = player.dy}
        table.insert(bullets,newBullet)
    end
    for i, b in ipairs(bullets) do
        b.x = b.x + (b.dx*dt)
        b.y = b.y + (b.dy*dt)
        if b.x < 0 and b.x > game.roomWidth and
            b.y < 0 and b.y > game.roomHeight then
            table.remove(bullets,i)    
        end
        for j, e in ipairs(enemies) do
            if distance(b.x,b.y,e.x,e.y) < e.width+8 then
                table.remove(enemies,j)
                table.remove(bullets,i)
            end
        end
    end
end

function bullet.draw()
    for i, b in ipairs(bullets) do
        love.graphics.circle("line",b.x,b.y,12)
    end
end