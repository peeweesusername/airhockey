import 'package:flame_forge2d/flame_forge2d.dart';

class AirRink extends BodyComponent {
  final Vector2 gameSize;

  AirRink({required this.gameSize});

  @override
  Body createBody() {
    //TODO: create gap at each end to fit goal
    final indices = <Vector2>[Vector2(0,0), Vector2(0, gameSize.y), Vector2(gameSize.x, gameSize.y), Vector2(gameSize.x,0), Vector2(0,0) ];
    final shape = ChainShape();
    shape.createChain(indices);
    final fixtureDef = FixtureDef(shape, density: 1.0, restitution: 0.9, friction: 0.0);
    final bodyDef = BodyDef(userData: this, position: Vector2.zero());
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}