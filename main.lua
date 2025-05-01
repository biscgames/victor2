victor = require("modules.victor")

objs = victor.objects
cams = victor.cameras

cameraMode = false

icon = love.graphics.newImage("image/icon.png")
camtest = love.graphics.newImage("image/camtest.png")

function love.load()
    cams:append("main",0,0,true)
    objs:append("main",icon)
    objs:append("cameraTest",camtest,300,-100,0.5)

    cams.main.ease.enabled = true
    objs.main.ease.enabled = true
end

function love.draw()
    love.graphics.setBackgroundColor(0.5,0.5,0.5)
    victor.drawObjects()
end

function love.keypressed(key)
    if key == "c" then
        cameraMode = not cameraMode
    end
end

function love.update()
    victor.easeStep()
    if love.keyboard.isDown("w","a","s","d") then
        local xAxis = (love.keyboard.isDown("d") and 1 or 0) - (love.keyboard.isDown("a") and 1 or 0)
        local yAxis = (love.keyboard.isDown("w") and 1 or 0) - (love.keyboard.isDown("s") and 1 or 0)

        if cameraMode then
            local xRef = cams.main.ease.x
            local yRef = cams.main.ease.y

            cams.main.ease.x = xRef + xAxis*2
            cams.main.ease.y = yRef + yAxis*2
        else
            local xRef = objs.main.ease.x
            local yRef = objs.main.ease.y

            objs.main.ease.x = xRef + xAxis*2
            objs.main.ease.y = yRef - yAxis*2
        end
    end
end