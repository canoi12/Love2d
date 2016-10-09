scene = require "scene"
require "screenmanager"
require "utils"

global = {}
global.camerax = 0
global.cameray = 0

actualPalette = 1

palette = {}
palette[1] = {
  {23.0, 23.0, 23.0, 255.0},
  {145.0, 80.0, 90.0, 255.0},
  {206.0, 177.0, 175.0, 255.0},
  {224.0, 215.0, 195.0, 255.0}
}

palette[2] = {
  {32.0, 65.0, 77.0, 255.0},
  {99.0, 155.0, 133.0, 255.0},
  {181.0, 220.0, 161.0, 255.0},
  {240.0, 254.0, 231.0, 255.0}
}

palette[3] = {
  {0.0, 0.0, 0.0, 255.0},
  {57.0, 56.0, 41.0, 255.0},
  {123.0, 113.0, 98.0, 255.0},
  {180.0, 165.0, 106.0, 255.0}
}

function love.load()
  myShader = love.graphics.newShader[[
  const int nColors = 4;
  extern vec4 colorsa[nColors];
  vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    /*vec4 color_1 = vec4(23.0, 23.0, 23.0, 255.0);
    vec4 color_2 = vec4(145.0, 80.0, 90.0, 255.0);
    vec4 color_3 = vec4(206.0, 177.0, 175.0, 255.0);
    vec4 color_4 = vec4(224.0, 215.0, 195.0, 255.0);*/

    vec4 colors[nColors];

    int nColorss = nColors;

    for (int i = 0; i < nColors; i++) {
      colors[i] = colorsa[i];
    }

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

    /*color_1 /= 255.0;
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
    return color_4;*/

    for (int i = 0; i < nColors; i++) {
      colors[i] /= 255;
    }

    float dist[nColors];

    for (int i = 0; i < nColors; i++) {
      dist[i] = 0;
    }

    for(int i = 0; i < nColors; i++) {
      float dist_r = (colors[i].r - pixel.r) * (colors[i].r - pixel.r);
      float dist_g = (colors[i].g - pixel.g) * (colors[i].g - pixel.g);
      float dist_b = (colors[i].b - pixel.b) * (colors[i].b - pixel.b);

      dist[i] = dist_r + dist_g + dist_b;
    }

    float d_min = min(dist[0], dist[1]);
    for (int i = 2; i < nColors; i++) {
      d_min = min(d_min, dist[i]);
    }

    for (int i = 0; i < nColors; i++) {
      colors[i].a = pixel.a;
    }

    for (int i = 0; i < nColors; i++) {
      if (d_min == dist[i])
        return colors[i];
    }

    //return pixel * color;
    //return vec4(1,0,0,1);
  }
  ]]

  bg = love.graphics.newImage("assets/image/bg.png")
  bg:setFilter("nearest", "nearest")

  canvas = love.graphics.newCanvas(166, 144)
  canvas:setFilter("nearest","nearest")

  scene:init()

  screenmanager:addScreen("level1", scene)

end

function love.update(dt)
  screenmanager:update(dt)
end

function love.draw()
  love.graphics.setCanvas(canvas)
  love.graphics.clear()
  love.graphics.setBackgroundColor(palette[actualPalette][3])
  love.graphics.push()

  screenmanager:draw()

  love.graphics.pop()
  love.graphics.setCanvas()
  --love.graphics.draw(bg, 0, 0, 0, 4, 4)

  --[[for i=1,4 do
    myShader:send("color_"..i, palette[1][i])
  end]]

  myShader:send("colorsa",palette[actualPalette][1], palette[actualPalette][2], palette[actualPalette][3], palette[actualPalette][4])
  --[[myShader:send("color_1", palette[1][1])
  myShader:send("color_2", palette[1][2])
  myShader:send("color_3", palette[1][3])
  myShader:send("color_4", palette[1][4])]]
  love.graphics.setShader(myShader)
  love.graphics.draw(canvas,0,0,0,4, 4)
  love.graphics.setShader()
end
