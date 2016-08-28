vector2 = {}
vector2.x = 0
vector2.y = 0

function vector2:new(o)
    o = o or {}
    return setmetatable(o, {__index = self})
end

function vector2:scale(v2)
    local aux = vector2:new()
    aux.x = self.x * v2.x
    aux.y = self.y * v2.y
    return aux
end

function vector2:dot(v2)
    return self.x * v2.x + self.y * v2.y
end

function vector2:sub(v2)
    local aux = vector2:new()
    aux.x = self.x - v2.x
    aux.y = self.y - v2.y
    return aux
end

function vector2:orto()
    local aux = vector2:new()
    aux.x = -self.y
    aux.y = self.x
    return aux
end