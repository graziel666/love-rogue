require ("maps")

function love.load()
    
  love.window.setMode(480, 480)

  --characters
  hero = {
    x = 200,
    y = 200,
    shield = false,
    sword = false,
    helmet = false
  }
  
  --maps
  maps = {town,ruins}
  lvl = 1
  Tileset = love.graphics.newImage("/res/Vexed/Full.png")
  HeroTiles = love.graphics.newImage("/res/Vexed/hero_end.png")
  tileW, tileH = 20,20
  local tilesetW, tilesetH = Tileset:getWidth(), Tileset:getHeight()
  local heroTilesW, heroTilesH = HeroTiles:getWidth(), HeroTiles:getHeight()
  
  --quads
  --tiles quads
  quad = {}

  for i=0,36 do
    for j=0,32 do
      table.insert(quad, love.graphics.newQuad(j*(tileW),i*(tileH), tileW, tileH, tilesetW, tilesetH))
    end
  end

  --character quads
  heroQuads = {}

  for i=0,1 do
    for j=0,5 do
      table.insert(heroQuads, love.graphics.newQuad(j*(tileW),i*(tileH), tileW, tileH, heroTilesW, heroTilesH))
    end
  end

end

function love.draw()
  drawMap()
  drawHero()
end

function love.update()
  playerInput()

end


function drawMap()
    for i, row in ipairs(maps[lvl]) do
      for j, tile in ipairs(row) do
        if tile ~=0   then
          love.graphics.draw(Tileset, quad[tile], j * tileW-tileW, i * tileH-tileH)
        end
       --animTiles(tile,j,i)
      end
    end
  end

  function playerInput()
    function love.keypressed(key)
      --local x = hero.x
      --local y = hero.y
      if key == "a" then
          hero.x = hero.x - 20
      elseif key == "d" then
          hero.x = hero.x + 20
      elseif key == "w" then
          hero.y = hero.y - 20
      elseif key == "s" then
          hero.y = hero.y + 20
      end

      if key == "b" then
        if test < 30 then
          test = test + 1
        else test = 1
        end
      end
      
      if key == "escape" then
        love.event.quit()
     end

      --equipment test

      if key == "1" then
        if hero.shield == true then
          hero.shield = false
          else hero.shield = true
        end
      elseif key == "2" then
        if hero.sword == true then
          hero.sword = false
          else hero.sword = true
        end
      elseif key == "3" then
        if hero.helmet == true then
          hero.helmet = false
          else hero.helmet = true
        end
      end

    end
  end

function drawHero()
  local model = 1

  --set model
  --models are 1 = hero with nothing, 2 = shield, 3 = sword, and 4 = shield and sword
  --models are 7 = hero with helmet, 8 = helmet + shield, 9 = helmet + sowrd, 10 = helmet + both 
  if (hero.shield == false and hero.sword == false and hero.helmet == false) then
    model = 1
  elseif (hero.shield == true and hero.sword == false and hero.helmet == false) then
    model = 2
  elseif (hero.shield == false and hero.sword == true and hero.helmet == false) then
    model = 3
  elseif (hero.shield == true and hero.sword == true) then
    model = 4
  elseif (hero.shield == false and hero.sword == false and hero.helmet == true) then
    model = 7
  elseif (hero.shield == true and hero.sword == false and hero.helmet == true) then
    model = 8
  elseif (hero.shield == false and hero.sword == true and hero.helmet == true) then
    model = 9
  end
  if (hero.shield == true and hero.sword == true and hero.helmet == true) then
    model = 10
  end

  love.graphics.draw(HeroTiles, heroQuads[model], hero.x,hero.y)
end