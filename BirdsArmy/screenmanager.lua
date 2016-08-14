screenmanager = {}

function approach(v1, v2, qtd)
    if v1 < v2 then
        v1 = v1 + qtd
    end
    if v1 > v2 then
        v1 = v1 - qtd
    end

    return v1
end

function screenmanager:new(o)
    local o = o or {}
    return setmetatable(o,{__index=self})
end

function screenmanager:update(dt)
    gameobject:update(dt)
end

function screenmanager:draw()
    gameobject:draw()
end