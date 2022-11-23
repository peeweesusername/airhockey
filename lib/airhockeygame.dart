import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:air_hockey/goal.dart';
import 'package:air_hockey/thepuck.dart';
import 'package:air_hockey/airrink.dart';
import 'package:air_hockey/playerpaddle.dart';

const double myZoomFactor = 15;
const double puckRadius = 1.5/myZoomFactor;
const double paddleRadius = 3.5/myZoomFactor;

class AirHockeyGame extends Forge2DGame with HasDraggables, TapDetector {
  //Needed to eliminate gravity vector
  AirHockeyGame() : super(gravity: Vector2(0, 0));

  late Body gameBody;
  late PlayerPaddle player1;
  late PlayerPaddle player2;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    camera.zoom = camera.zoom * myZoomFactor;
    Vector2 gameSize = screenToWorld(camera.viewport.effectiveSize);
    gameBody = world.createBody(BodyDef());
    player1 = PlayerPaddle(
        position: Vector2(gameSize.x / 2, gameSize.y - (2 * paddleRadius)),
        radius: paddleRadius,
        linearVelocity: Vector2.zero(),
        playernumber: 1);
    player2 = PlayerPaddle(
        position: Vector2(gameSize.x / 2, (2 * paddleRadius)),
        radius: paddleRadius,
        linearVelocity: Vector2.zero(),
        playernumber: 2);
    add(AirRink(gameSize: gameSize));
    add(ThePuck(position: Vector2(gameSize.x / 2, gameSize.y / 2),
        radius: puckRadius,
        linearVelocity: Vector2.zero()));
    add(Goal(gameSize: gameSize, playernumber: 1));
    add(Goal(gameSize: gameSize, playernumber: 2));
    add(player1);
    add(player2);
  }

  void removePuck(ThePuck thePuck) {
    remove(thePuck);
  }

  void addPuck(Vector2 position, Vector2 velocity, double radius) {
    add(ThePuck(position: position, radius: radius, linearVelocity: velocity));
  }

  @override
  void onTap() {
    if (overlays.isActive('Menu')) {
      overlays.remove('Menu');
      resumeEngine();
    } else {
      overlays.add('Menu');
      pauseEngine();
    }
  }
}
