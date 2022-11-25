import 'package:flutter/material.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:air_hockey/contacthandlers.dart';
import 'package:air_hockey/airhockeygame.dart';
import 'package:air_hockey/playerpaddle.dart';

class Goal extends BodyComponent {
  final Vector2 gameSize;
  PlayerColor whichplayer;

  late AirHockeyGame parentGame = findParent() as AirHockeyGame;

  Goal({required this.gameSize, required this.whichplayer});

  @override
  Body createBody() {
    Vector2 position;
    setColor(Colors.red);
    if (whichplayer == PlayerColor.redPlayer)
    {
      //TODO: use the scale factor here and place slighty beyond rink wall
      position = Vector2(gameSize.x/2, gameSize.y+0.01);
    }
    else
    {
      //TODO: use the scale factor here and place slighty beyond rink wall
      position = Vector2(gameSize.x/2, -0.01);
    }
    final shape = PolygonShape ();
    //TODO: use the scale factor here
    shape.setAsBoxXY(0.4, 0.02);
    final mycontact = goalContactCallback(theGoal: this);
    final fixtureDef = FixtureDef(shape, density: 1.0, restitution: 0.0, friction: 1.0);
    final bodyDef = BodyDef(position: position, type: BodyType.static, userData: mycontact);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

}