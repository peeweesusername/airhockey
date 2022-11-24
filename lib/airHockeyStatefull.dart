import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:air_hockey/airhockeygame.dart';
import 'package:air_hockey/gamemenus.dart';

class AirHockeyGameStatefull extends StatefulWidget {
  const AirHockeyGameStatefull({super.key});
  @override
  State<AirHockeyGameStatefull> createState() => _AirHockeyGameStatefull();
}

class _AirHockeyGameStatefull extends State<AirHockeyGameStatefull> {
  late AirHockeyGame myAirHockeyGame;
  int _player1Score = 0;
  int _player2Score = 0;

  void PlayreScored(int player) {
    print("player # " + player.toString() + " scored");
    setState(() {
      if (player == 1) {
        _player1Score++;
      }
      else {
        _player2Score++;
      }
    });
    print("_player1Score: " + _player1Score.toString());
    print("_player2Score: " + _player2Score.toString());
  }

  @override
  Widget build(BuildContext context) {
    myAirHockeyGame = AirHockeyGame();
    myAirHockeyGame.paused = false;
    myAirHockeyGame.PlayreScored = PlayreScored;
    double x = MediaQuery.of(context).size.width.roundToDouble();
    double y = MediaQuery.of(context).size.height.roundToDouble();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Container(
            constraints: BoxConstraints.expand(width: x, height: y),
            child: GameWidget<AirHockeyGame>(
              game: myAirHockeyGame,
              overlayBuilderMap: const
                {'PauseMenu': pauseMenuBuilder, 'FaceoffMenu': faceoffMenuBuilder},
            ),
          ),
          ],
        ),
      ),
    );
  }
}
