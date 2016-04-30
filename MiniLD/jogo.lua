jogo = {}

function jogo.load()
    background.load()
end

function jogo.update(dt)
    background.update(dt)
    nave.update(dt)
    bullet.update(dt)
end

function jogo.draw()
    background.draw()
    nave.draw()
    bullet.draw()
end