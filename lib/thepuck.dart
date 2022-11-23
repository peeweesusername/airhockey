import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:air_hockey/contacthandlers.dart';

class ThePuck extends BodyComponent with Draggable {
  Vector2 position;
  double radius;
  Vector2 linearVelocity;
  final Vector2 acceleration = Vector2.zero();

  ThePuck({required this.position, required this.radius, required this.linearVelocity});

  @override
  Body createBody() {
    final shape = CircleShape()..radius = radius;
    final mycontact = puckContactCallback(thePuck: this);
    final fixtureDef = FixtureDef(shape, density: 0.1, restitution: 0.3, friction: 0.1);
    final bodyDef = BodyDef(position: position, linearVelocity: linearVelocity, type: BodyType.dynamic, userData: mycontact);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onDragStart(DragStartInfo details) {
    return false;
  }

  @override
  bool onDragUpdate(DragUpdateInfo details) {
    final worldDelta = Vector2(1, 1)..multiply(details.delta.game);
    body.applyLinearImpulse(worldDelta/100);
    return false;
  }

  @override
  bool onDragEnd(DragEndInfo details) {
    return false;
  }
}
