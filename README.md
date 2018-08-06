# SNDBOX

*This project was created as part of an Interactive Media class final in collabration with another student.*

![SNDBOX!](/images/image1.jpg)

Meet SNDBOX, A musical sandbox that creates different sounds depending on where you pile up the sound.

## How it started

I was really interested in the different kinds of mediums we could use to illicit interactivity and I suppose I was looking for something that in itself is interesting to interact with and then go ahead and add a whole other layer.

Collaborating with a music student, she brought her sound magic to the concept and we began creating something we were both incredibly excited about.

## How it works

Using a Kinect, we extracted it's depth image and depth values and applied a 3 by 3 grid. The highest point above a specified threshold in each quadrant triggers a sound unique to that quadrant. The threshold is definitely the most finicky part, we had to make sure that no sound played when there were no piles or when the piles were too small but that it also doesn't take too big of a pile to trigger a sound. 

We finally got a good grasp of it when we converted the depth values into meters and started better understanding how those numbers translated in the real world.

You can find that conversation equation and many more other points that guided us in Daniel Shiffman's [tutorial](https://shiffman.net/p5/kinect/)
