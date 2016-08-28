vector3 = {}
vector3.x = 0
vector3.y = 0
vector3.z = 0

function vector3:new(o)
    o = o or {}
    return setmetatable(o,{__index=self})
end

function vector3:mul(v)
    local aux = vector3:new()
    aux.x = self.x * v
    aux.y = self.y * v
    aux.z = self.z * v

    return aux
end

function vector3:sum(v)
    local aux = vector3:new()
    aux.x = self.x + v
    aux.y = self.y + v
    aux.z = self.z + v

    return aux
end

function vector3:sumV3(v)
    local aux = vector3:new()
    aux.x = self.x + v.x
    aux.y = self.y + v.y
    aux.z = self.z + v.z

    return aux
end