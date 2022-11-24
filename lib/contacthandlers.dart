import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:air_hockey/airhockeygame.dart';
import 'package:air_hockey/thepuck.dart';
import 'package:air_hockey/playerpaddle.dart';
import 'package:air_hockey/goal.dart';

class puckContactCallback extends ContactCallbacks {
  final ThePuck thePuck;
  late AirHockeyGame parentGame = thePuck.findParent() as AirHockeyGame;

  puckContactCallback({required this.thePuck});

  @override
  beginContact(Object other, Contact contact)  {
    super.beginContact(other, contact);

   if (other is PlayerPaddle) {
      //FlameAudio.play('boing.mp3');
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    super.beginContact(other, contact);
  }

}

class paddleContactCallback extends ContactCallbacks {
  final PlayerPaddle thePaddle;
  late AirHockeyGame parentGame = thePaddle.findParent() as AirHockeyGame;

  paddleContactCallback({required this.thePaddle});

  @override
  beginContact(Object other, Contact contact)  {
    super.beginContact(other, contact);
  }

  @override
  void endContact(Object other, Contact contact) {
    super.beginContact(other, contact);
  }
}

class goalContactCallback extends ContactCallbacks {
  final Goal theGoal;
  late AirHockeyGame parentGame = theGoal.findParent() as AirHockeyGame;

  goalContactCallback({required this.theGoal});

  @override
  beginContact(Object other, Contact contact)  {
    super.beginContact(other, contact);
    if (other is puckContactCallback) {
      parentGame.PlayreScored(theGoal.playernumber);
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    super.beginContact(other, contact);
  }
}