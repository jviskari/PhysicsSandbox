# PhysicsSandbox
spring physics with processing and vectors

How hard can it be? How hard would you like it to be?

I'm a simple person and like simple things. 

This is a little program written in Processing Language to demonstrate how easy it is to write a little 2D mechanics simulation.

When doing graphics programming, vectors are the thing. Yes, the very same vectors from the high school math class. Except, you don't have to memorize the formulae. Computer does the hard work for you.

Then there are couple of basic physics formulae to understand.

f=ma => a=f/m
f=kx
==> a=kx/m

v=a*t

s=v*t

And how this maps to maps to computer graphics.

Usually in high school physics velocity is expressed as meters/second. In computer screen which consists of pixels, it's more meaning full
to express velocity of object as pixels/frame. For example, if the frameRate of application is 50 frames/second, it means that picture is
drawn 50 times per second to screen. If velocity is 1 pixel/frame this means that during 1 second of time object has moved 50 pixels in screen.
So in 10 seconds the object moves 500 pixels.

Same goes with physics. gravity for example is 9.81 m/s². This means that every seconds velocity increases by 9.81 m/s. You would like to define acceleration that expresses how many pixels/frame velocity increases. Typically the value is under 1 because remember that if you set 1 or greater the speed can be much too fast after a second, in fact you might not even see the object if it flies at speed of several hundred pixels per frame.

Third thing is that you should start thinking in steps, to get rid of the 't' in formulae. If frame rate is 50 frames per second, t advances at 1/50 s steps. 

acceleration, velocity and position are vectors, with x and y component.

In this simulation each frame.

1) direction vector from object to mouse cursor is determined.  dir = Pmouse-Pobject.
2) it's assumed that m=1 so acceleration is magnitude of direction vector * k. (k. is like spring coefficient) Longer the distance (magnitude of the vector) bigger the force and bigger the acceleration. (f=kx)
3) new velocity is calculated based on the acceleration. v=v0+a. (remember velocity is pixels/frame and acceration pixels/frame^2), so in 1 frame step acceleration just added to velocity.
4) new position is p=p0+v. It's like integrating the formula over 1/50s period. Basically it's like conversion of multiplication to sum.
   Example a+a+a = 3*a.
   
   Advantage of using vectors is that you get rid of the trigonometric functions and x and y dimensions are handled at the same time. This keeps the amount of code relatively low.
   
Some ideas to make this demo more interesting:
1) Link objects together and use f=kx as a binding force
2) Add repulsion so that objects push each other away.
3) Try to make spring force more power full at close distance by using 1/k



4) Make mouse cursor to draw
   






