pixToMet = 32
love.physics.setMeter(pixToMet)

local world = love.physics.newWorld(0,9.81*pixToMet,true);

objects = {}
objects.ground = {}
objects.ball = {}

objects.ground.x = 640/2
objects.ground.y = 480-64/2
objects.ground.w = 640
objects.ground.h = 64

objects.ground.body = love.physics.newBody(world,objects.ground.x,objects.ground.y)

objects.ground.shape = love.physics.newRectangleShape(objects.ground.w,objects.ground.h)
objects.ground.fixture = love.physics.newFixture(objects.ground.body,objects.ground.shape,0)
--objects.ground.fixture:setRestitution(.9)

objects.ball.x = 0
objects.ball.y = 0
objects.ball.r = 16

objects.ball.body = love.physics.newBody(world,objects.ball.x,objects.ball.y,"dynamic")
objects.ball.shape = love.physics.newCircleShape(objects.ball.r)
objects.ball.fixture = love.physics.newFixture(objects.ball.body,objects.ball.shape,1)
objects.ball.fixture:setRestitution(.2)

function love.load()

end

function love.update(dt)
    world:update(dt)
    
    local x, y = objects.ball.body:getLinearVelocity()
    
    if love.keyboard.isDown("right") then
        objects.ball.body:applyForce(400,0)
        if x > 200 then
            objects.ball.body:setLinearVelocity(200,y)
        end
    elseif love.keyboard.isDown("left") then
        objects.ball.body:applyForce(-400,0)
        if x < -200 then
            objects.ball.body:setLinearVelocity(-200,y)
        end
    end
    if love.keyboard.isDown("up") then
        objects.ball.body:applyForce(0,-4000)
    end
end

function love.draw()
    love.graphics.polygon("line",objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
    love.graphics.circle("line",objects.ball.body:getX(),objects.ball.body:getY(),objects.ball.shape:getRadius())
end