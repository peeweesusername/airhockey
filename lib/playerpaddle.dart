import 'package:flutter/material.dart' hide Draggable;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:air_hockey/contacthandlers.dart';
import 'package:air_hockey/airhockeygame.dart';

enum PlayerColor {
  redPlayer,
  bluePlayer,
  noPlayer
}

class PlayerPaddle extends BodyComponent with Draggable {
  Vector2 position;
  double radius;
  Vector2 linearVelocity;
  PlayerColor whichplayer;

  MouseJoint? mouseJoint;
  late AirHockeyGame parentGame = findParent() as AirHockeyGame;

  PlayerPaddle({required this.position, required this.radius, required this.linearVelocity, required this.whichplayer});

  @override
  Body createBody() {
    if (whichplayer == PlayerColor.redPlayer)
    {
      setColor(Colors.red);
    }
    else
    {
      setColor(Colors.blue);
    }
    final shape = CircleShape()..radius = radius;
    final mycontact = paddleContactCallback(thePaddle: this);
    final fixtureDef = FixtureDef(shape, density: 1.0, restitution: 0.0, friction: 1.0);
    final bodyDef = BodyDef(position: position, linearVelocity: linearVelocity, type: BodyType.dynamic, userData: mycontact);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onDragStart(DragStartInfo info) {
    return false;
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {

    final mouseJointDef = MouseJointDef()
      ..maxForce = body.mass * 1000
      ..frequencyHz = 10
      ..dampingRatio = 0.0
      ..target.setFrom(body.position)
      ..collideConnected = false
      ..bodyA = parentGame.gameBody
      ..bodyB = body;

    if (mouseJoint == null) {
      mouseJoint = MouseJoint(mouseJointDef);
      world.createJoint(mouseJoint!);
    }

    mouseJoint?.setTarget(info.eventPosition.game);

    return false;
  }

  @override
  bool onDragEnd(DragEndInfo info) {
    if (mouseJoint == null) {
      return true;
    }
    world.destroyJoint(mouseJoint!);
    mouseJoint = null;
    body.linearVelocity = body.linearVelocity/20;
    return false;
  }

}
