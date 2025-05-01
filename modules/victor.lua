cameras = {}
objects = {}
signals = {}

function signals.newObject(object)
    return object
end
function signals.newCamera(camera)
    return camera
end

function countKeys(table)
    local count = 0
    for _,_ in pairs(table) do
        count = count + 1
    end
    return count
end

function cameras:anyEnabled()
    for _,camera in pairs(self) do
        if type(camera) == "table" then
            if camera.enabled then
                return true,camera
            end
        end
    end
    return false,nil
end

function cameras:append(name,x,y,enabled)
    self[name] = {
        coordinates = {
            x = x or 0,
            y = y or 0,
            zoom = 1
        },
        enabled = enabled or false,
        ease = {
            enabled = false,
            speed = 0.25,
            x = x,
            y = y,
            zoom = 1
        }
    }
    signals.newCamera(self[name])
end

function objects:append(name,draw,x,y,scaleFactor,color)
    self[name] = {
        drawable = draw,
        coordinates = {
            x = x or 0,
            y = y or 0
        },
        scaleFactor = scaleFactor or 1,
        color = color or {1,1,1,1},
        center = {},
        ease = {
            enabled = false,
            speed = 0.25,
            x = x or 0,
            y = y or 0
        }
    }

    local object = self[name]
    
    function object.center:update()
        self.x = (love.graphics.getWidth()-object.drawable:getWidth())/2
        self.y = (love.graphics.getHeight()-object.drawable:getHeight())/2
    end
    object.center:update()

    signals.newObject(self[name])

    return object
end

function drawObjects(number)
    number = number or countKeys(objects)

    local selectedObjects = {}
    local count = 0
    for _,object in pairs(objects) do
        if type(object) == "table" then
            count = count + 1
            if count > number then
                break
            end

            local anyEnabled,camera = cameras:anyEnabled()
            local camX, camY, zoom
            if anyEnabled then
                camX = camera.coordinates.x
                camY = camera.coordinates.y
                zoom = camera.coordinates.zoom
            else
                camX = 0
                camY = 0
                zoom = 1
            end

            love.graphics.draw(
                object.drawable, 
                (object.coordinates.x+object.center.x)-camX,
                (object.coordinates.y+object.center.y)+camY,
                0,
                object.scaleFactor
            )
        end
    end

    return selectedObjects
end

function easeStep()
    for _,object in pairs(objects) do
        if type(object) == "table" then
            if object.ease.enabled then
                object.coordinates.x = object.coordinates.x + (object.ease.x-object.coordinates.x)*object.ease.speed
                object.coordinates.y = object.coordinates.y + (object.ease.y-object.coordinates.y)*object.ease.speed
            end
        end
    end

    for _,camera in pairs(cameras) do
        if type(camera) == "table" then
            if camera.ease.enabled then
                camera.coordinates.x = camera.coordinates.x + (camera.ease.x-camera.coordinates.x)*camera.ease.speed
                camera.coordinates.y = camera.coordinates.y + (camera.ease.y-camera.coordinates.y)*camera.ease.speed
                camera.coordinates.zoom = camera.coordinates.zoom + (camera.ease.zoom-camera.coordinates.zoom)*camera.ease.speed
            end
        end
    end
end

return {
    cameras = cameras,
    objects = objects,
    signal = signals,
    drawObjects = drawObjects,
    easeStep = easeStep
}
