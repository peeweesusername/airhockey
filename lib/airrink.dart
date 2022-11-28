import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:air_hockey/globals.dart';

class AirRinkLeftSide extends BodyComponent {
  final Vector2 gameSize;

  AirRinkLeftSide({required this.gameSize});

  @override
  Body createBody() {
    //Allow for gap in rink wall for goal
    final indices = <Vector2>[Vector2((gameSize.x/2)-goalWidth,0),
      Vector2(0,0), Vector2(0, gameSize.y),
      Vector2((gameSize.x/2)-goalWidth, gameSize.y)];

    final shape = ChainShape();
    shape.createChain(indices);
    final fixtureDef = FixtureDef(shape, density: 1.0, restitution: 0.7, friction: 0.2);
    final bodyDef = BodyDef(userData: this, position: Vector2.zero());
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class AirRinkRightSide extends BodyComponent {
  final Vector2 gameSize;

  AirRinkRightSide({required this.gameSize});

  @override
  Body createBody() {
    //Allow for gap in rink wall for goal
    final indices = <Vector2>[Vector2((gameSize.x/2)+goalWidth,0),
      Vector2(gameSize.x,0),
      Vector2(gameSize.x, gameSize.y),
      Vector2((gameSize.x/2)+goalWidth, gameSize.y)];
    final shape = ChainShape();
    shape.createChain(indices);
    final fixtureDef = FixtureDef(shape, density: 1.0, restitution: 0.7, friction: 0.2);
    final bodyDef = BodyDef(userData: this, position: Vector2.zero());
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}