import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:air_hockey/globals.dart';
import 'package:air_hockey/goal.dart';
import 'package:air_hockey/thepuck.dart';
import 'package:air_hockey/airrink.dart';
import 'package:air_hockey/playerpaddle.dart';

const double puckRadius = 1.5/myZoomFactor;
const double paddleRadius = 3.5/myZoomFactor;

const int winningScore = 15;

class AirHockeyGame extends Forge2DGame with HasDraggables, TapDetector {
  //Needed to eliminate gravity vector
  AirHockeyGame() : super(gravity: Vector2(0, 0));

  int redscore = 0;
  int bluescore = 0;
  PlayerColor theWinner = PlayerColor.noPlayer;
  PlayerColor whoScored = PlayerColor.noPlayer;
  Vector2 redHomePosition = Vector2.zero();
  Vector2 blueHomePosition = Vector2.zero();
  late Body gameBody;
  late Vector2 gameSize;
  late PlayerPaddle redplayer;
  late PlayerPaddle blueplayer;
  late ThePuck thePuck;
  late Function(PlayerColor) PlayerScored;
  late Function() NewGame;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    camera.zoom = camera.zoom * myZoomFactor;
    gameSize = screenToWorld(camera.viewport.effectiveSize);
    gameBody = world.createBody(BodyDef());
    redHomePosition = Vector2(gameSize.x / 2, gameSize.y - (2 * paddleRadius));
    redplayer = PlayerPaddle(
        position: redHomePosition,
        radius: paddleRadius,
        linearVelocity: Vector2.zero(),
        whichplayer: PlayerColor.redPlayer);
    blueHomePosition = Vector2(gameSize.x / 2, (2 * paddleRadius));
    blueplayer = PlayerPaddle(
        position: blueHomePosition,
        radius: paddleRadius,
        linearVelocity: Vector2.zero(),
        whichplayer: PlayerColor.bluePlayer);
    await FlameAudio.audioCache.load('charge.mp3');
    await FlameAudio.audioCache.load('score_air_horn.mp3');
    add(AirRinkLeftSide(gameSize: gameSize));
    add(AirRinkRightSide(gameSize: gameSize));
    add(Goal(gameSize: gameSize, whichplayer: PlayerColor.redPlayer));
    add(Goal(gameSize: gameSize, whichplayer: PlayerColor.bluePlayer));
    add(redplayer);
    add(blueplayer);
    overlays.add('FaceoffMenu');
  }

  void paddlesReset() {
    redplayer.body.clearForces();
    blueplayer.body.clearForces();
    redplayer.setPaddlePosition(redHomePosition);
    blueplayer.setPaddlePosition(blueHomePosition);
  }

  void restartGame() {
    redscore = 0;
    bluescore = 0;
    whoScored = PlayerColor.noPlayer;
    paddlesReset();
    overlays.add('FaceoffMenu');
  }

  void removePuck() {
    remove(thePuck);
  }

  void updateScore(int redscore, int bluescore) {
    this.redscore = redscore;
    this.bluescore = bluescore;

    FlameAudio.play('score_air_horn.mp3');

    if (this.redscore == winningScore) {
      winner(PlayerColor.redPlayer);
    }
    else if (this.bluescore == winningScore) {
      winner(PlayerColor.bluePlayer);
    }
    else {
      faceOff();
    }
  }

  void faceOff() {
    paddlesReset();
    overlays.add('FaceoffMenu');
  }

  void winner(PlayerColor winner) {
    theWinner = winner;
    overlays.add('WinnerMenu');
  }

  Future<void> puckDrop() async {
    FlameAudio.play('charge.mp3');
    Vector2 droppoint;
    double impulseX;
    double impulseY = 0.0;
    Random random = Random();
    if (random.nextBool()) {
      droppoint = Vector2(gameSize.x / 100, gameSize.y / 2);
    } else {
      droppoint = Vector2(gameSize.x, gameSize.y / 2);
    }
    impulseX = 0.01;
    impulseY = (random.nextDouble()-0.5)*0.02;
    thePuck = ThePuck(position: droppoint, radius: puckRadius);
    await add(thePuck);
    thePuck.body.applyLinearImpulse(Vector2(impulseX, impulseY));
  }

  @override
  void onTap() {
    if (overlays.isActive('WinnerMenu')) {
      return;
    }
    else if (overlays.isActive('FaceoffMenu')) {
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
