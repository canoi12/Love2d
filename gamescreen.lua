gamescreen = {}
function gamescreen.load()
    player.load()
    bloco.load()
    enemy.load()
end

function gamescreen.update(dt)
    camera.x = math.clamp(player.x-(game.windowWidth/2),0,game.roomWidth-(game.windowWidth))
    enemy.update(dt)
    player.update(dt)
end

function gamescreen.draw()
    camera.set()
    love.graphics.setColor(255,255,255)
    love.graphics.draw(game.background,game.bgquad,0,0)
    player.draw(dt)
    bloco.draw()
    enemy.draw()
    camera.unset()
end