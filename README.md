Welcome to Victor2! This readme will tell you all about it!


![icon](https://github.com/user-attachments/assets/397885a5-b61c-49d7-ac6b-a1035e233082)


To append an object to your game, use `victor.objects:append(name,drawable,x (0),y (0),scaleFactor (1),color (1,1,1,1))`

Object attributes:
- drawable
- coordinates > x, y
- center > x, y (These are usually set automatically, but can be changed)
- ease > enabled (false), x, y, speed (0.25)
<br>
To append a camera to your game, use `victor.cameras:append(name,x (0),y (0),enabled (false))`

Camera attributes:
- enabled
- coordinates > x, y
- ease > enabled (false), x, y, speed (0.25)

To reference an object, use `victor.objects.name`

To reference a camera, use `victor.cameras.name`

To draw all objects, put `victor.cameras:drawObjects()` inside of the `love.draw()` function
