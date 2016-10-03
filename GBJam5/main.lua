player = require "player"

function love.load()
  myShader = love.graphics.newShader[[
  vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec4 color_1 = vec4(23.0, 23.0, 23.0, 255.0);
    vec4 color_2 = vec4(145.0, 80.0, 90.0, 255.0);
    vec4 color_3 = vec4(206.0, 177.0, 175.0, 255.0);
    vec4 color_4 = vec4(224.0, 215.0, 195.0, 255.0);
    vec4 pixel = Texel(texture, texture_coords);

    float pixH = 1.0 / 160.0;
    float pixV = 1.0 / 144.0;

    vec4 test = Texel(texture, texture_coords + vec2(pixH, 0.0));
    pixel.a = max(pixel.a, test.a);

    test = Texel(texture, texture_coords - vec2(pixH, 0.0));
    pixel.a = max(pixel.a, test.a);

    test = Texel(texture, texture_coords + vec2(0.0, pixV));
    pixel.a = max(pixel.a, test.a);

    test = Texel(texture, texture_coords - vec2(0.0, pixV));
    pixel.a = max(pixel.a, test.a);

    color_1 /= 255.0;
    color_2 /= 255.0;
    color_3 /= 255.0;
    color_4 /= 255.0;

    float dist_r = (color_1.r - pixel.r) * (color_1.r - pixel.r);
    float dist_g = (color_1.g - pixel.g) * (color_1.g - pixel.g);
    float dist_b = (color_1.b - pixel.b) * (color_1.b - pixel.b);

    float dist_1 = dist_r + dist_g + dist_b;

    dist_r = (color_2.r - pixel.r) * (color_2.r - pixel.r);
    dist_g = (color_2.g - pixel.g) * (color_2.g - pixel.g);
    dist_b = (color_2.b - pixel.b) * (color_2.b - pixel.b);

    float dist_2 = dist_r + dist_g + dist_b;

    dist_r = (color_3.r - pixel.r) * (color_3.r - pixel.r);
    dist_g = (color_3.g - pixel.g) * (color_3.g - pixel.g);
    dist_b = (color_3.b - pixel.b) * (color_3.b - pixel.b);

    float dist_3 = dist_r + dist_g + dist_b;

    dist_r = (color_4.r - pixel.r) * (color_4.r - pixel.r);
    dist_g = (color_4.g - pixel.g) * (color_4.g - pixel.g);
    dist_b = (color_4.b - pixel.b) * (color_4.b - pixel.b);

    float dist_4 = dist_r + dist_g + dist_b;

    float d_min = min(dist_1, dist_2);
    d_min = min(d_min, dist_3);
    d_min = min(d_min, dist_4);

    color_1.a = pixel.a;
    color_2.a = pixel.a;
    color_3.a = pixel.a;
    color_4.a = pixel.a;

    if (d_min == dist_1)
    return color_1;
    if (d_min == dist_2)
    return color_2;
    if (d_min == dist_3)
    return color_3;
    if (d_min == dist_4)
    return color_4;

    //return pixel * color;
    //return vec4(1,0,0,1);
  }
  ]]

  floor = love.graphics.newImage("assets/image/floor.png")
  plant = love.graphics.newImage("assets/image/plant.png")
  bg = love.graphics.newImage("assets/image/bg.png")
  bg:setFilter("nearest", "nearest")

  canvas = love.graphics.newCanvas(166, 144)
  canvas:setFilter("nearest","nearest")

  char = player:new{anim={}}
  char:init()
end

function love.update(dt)
  char:update(dt)
end

function love.draw()
  love.graphics.setBackgroundColor(205.0, 178.0, 172.0, 255.0)
  love.graphics.setCanvas(canvas)
  love.graphics.clear()
  love.graphics.push()

  char:draw()

  for i=0,10 do
    love.graphics.draw(floor, i*16, 128)
    love.graphics.draw(plant, i * 32, 121)
  end

  love.graphics.pop()
  love.graphics.setCanvas()
  love.graphics.draw(bg, 0, 0, 0, 4, 4)
  love.graphics.setShader(myShader)
  love.graphics.draw(canvas,0,0,0,4, 4)
  love.graphics.setShader()
end
