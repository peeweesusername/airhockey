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
  late Vector2 gameSize;
  late PlayerPaddle player1;
  late PlayerPaddle player2;
  late ThePuck thePuck;
  late Function(int) PlayreScored;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    camera.zoom = camera.zoom * myZoomFactor;
    gameSize = screenToWorld(camera.viewport.effectiveSize);
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
    add(Goal(gameSize: gameSize, playernumber: 1));
    add(Goal(gameSize: gameSize, playernumber: 2));
    add(player1);
    add(player2);
    overlays.add('FaceoffMenu');
  }

  void removePuck() {
    remove(thePuck);
  }

  void faceOff() {
    overlays.add('FaceoffMenu');
  }

  Future<void> puckDrop() async {
    thePuck = ThePuck(position: Vector2(gameSize.x / 100, gameSize.y / 2),
        radius: puckRadius);
    await add(thePuck);
    thePuck.body.applyLinearImpulse(Vector2(0.01, 0));
  }

  @override
  void onTap() {
    if (overlays.isActive('FaceoffMenu')) {
      return;
    }
    else if (overlays.isActive('PauseMenu')) {
      overlays.remove('PauseMenu');
      resumeEngine();
    } else {
      overlays.add('PauseMenu');
      pauseEngine();
    }
  }
}
