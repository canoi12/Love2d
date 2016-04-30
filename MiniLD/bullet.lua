bullets = {}
bullet = {}

function bullet.load()
    bullet.speed = 250
    bullet.image = love.graphics.newImage("assets/efeitos/bullet player 1b.png")
    
    bullet.delay = 0.10
end

function bullet.update(dt)
    for i,b in ipairs(bullets) do
        b.x = b.x + (bullet.speed*dt)
        if b.x > 720 then
            table.remove(bullets,i)
        end
    end
    
    if love.keyboard.isDown("z") and bullet.delay <= 0 then
        newBullet = {x = nave.x,y = nave.y}
        table.insert(bullets,newBullet)
        bullet.delay = 0.10
    end
    bullet.delay = bullet.delay - 0.01
end

function bullet.draw()
    for i,b in ipairs(bullets) do
        love.graphics.draw(bullet.image,b.x,b.y)
    end
end