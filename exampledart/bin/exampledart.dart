import 'package:liquid2d/liquid2d.dart';
import 'package:liquid2d/src/liquid2d.dart';
import 'package:vector_math/vector_math_64.dart';

void main(List<String> arguments) {
  Vector2 gravity = Vector2(0, -100);

  // Create an empty space.
  var space = Space()..setGravity(gravity: gravity);

  // Add a static line segment shape for the ground.
  // We'll make it slightly tilted so the ball will roll off.
  // We attach it to a static body to tell Chipmunk it shouldn't be movable.
  var ground = SegmentShape(body: space.getStaticBody(), a: Vector2(-20, 5), b: Vector2(20, -5), radius: 0)..setFriction(1);
  space.addShape(shape: ground);
  // Now let's make a ball that falls onto the line and rolls off.
  // First we need to make a cpBody to hold the physical properties of the object.
  // These include the mass, position, velocity, angle, etc. of the object.
  // Then we attach collision shapes to the cpBody to give it a size and shape.

  double radius = 5;
  double mass = 1;

  // The moment of inertia is like mass for rotation
  // Use the cpMomentFor*() functions to help you approximate it.
  var moment = Moment.forCircle(mass, 0, radius, Vector2.zero());

  // The cpSpaceAdd*() functions return the thing that you are adding.
  // It's convenient to create and add an object in one line.
  var ballBody = space.addBody(body: Body(mass: mass, moment: moment))..setPosition(pos: Vector2(0, 5));

  // Now we create the collision shape for the ball.
  // You can create multiple collision shapes that point to the same body.
  // They will all be attached to the body and move around to follow it.
  space.addShape(shape: CircleShape(body: ballBody, radius: radius, offset: Vector2.zero())..setFriction(0.7));

  // Now that it's all set up, we simulate all the objects in the space by
  // stepping forward through time in small increments called steps.
  // It is *highly* recommended to use a fixed size time step.
  double timeStep = 1.0 / 60.0;
  Vector2 pos = Vector2.zero();
  Vector2 vel = Vector2.zero();
  for (double time = 0; time < 100; time += timeStep) {
    pos = ballBody.getPosition();
    vel = ballBody.getVelocity();
    print(
      "Time is $time. ballBody is at (${pos.x}, ${pos.y}). It's velocity is (${vel.x}, ${pos.y})\n",
    );
    //print(time);

    space.step(dt: timeStep);
  }

  // Clean up our objects and exit!
  // cpShapeFree(ballShape);
  // cpBodyFree(ballBody);
  // cpShapeFree(ground);
  // cpSpaceFree(space);
  space.destroy();
  // var space2 = Space()..setGravity(gravity: gravity);
  // space2.destroy();
  // var space3 = Space()..setGravity(gravity: gravity);
  // space3.destroy();
  // var space4 = Space()..setGravity(gravity: gravity);
  // space4.destroy();
  // var space5 = Space()..setGravity(gravity: gravity);
  // space5.destroy();
}
