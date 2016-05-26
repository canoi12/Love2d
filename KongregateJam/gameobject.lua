gameobject = {}

function gameobject:new(o)
    o = o or {}
    return setmetatable(o,{_index=self})
end

function gameobject:init()

end

function gameobject:update(dt)

end

function gameobject:draw()

end