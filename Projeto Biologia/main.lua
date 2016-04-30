require "tabela"

function love.load()
    tabela.load()
end

function love.update(dt)
    tabela.update(dt)
end

function love.draw()
    tabela.draw()
end

function love.mousepressed(x,y,bt)
    tabela.mousepressed(x,y,bt)
end