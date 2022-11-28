import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:air_hockey/airhockeygame.dart';
import 'package:air_hockey/gamemenus.dart';
import 'package:air_hockey/playerpaddle.dart';

class AirHockeyGameStatefull extends StatefulWidget {
  const AirHockeyGameStatefull({super.key});
  @override
  State<AirHockeyGameStatefull> createState() => _AirHockeyGameStatefull();
}

class _AirHockeyGameStatefull extends State<AirHockeyGameStatefull> {
  late AirHockeyGame myAirHockeyGame;
  late  int _playerRedScore;
  late  int _playerBlueScore;

  void PlayreScored(PlayerColor whichplayer) {
    setState(() {
      if (whichplayer == PlayerColor.redPlayer) {
        myAirHockeyGame.whoScored = PlayerColor.redPlayer;
        _playerRedScore++;
      }
      else {
        myAirHockeyGame.whoScored = PlayerColor.bluePlayer;
        _playerBlueScore++;
      }
      myAirHockeyGame.removePuck();
      myAirHockeyGame.updateScore(_playerRedScore, _playerBlueScore);
    });
  }

  void NewGame() {
    setState(() {
      _playerRedScore = 0;
      _playerBlueScore = 0;
    });
    myAirHockeyGame.restartGame();
  }

  @override
  void initState() {
    super.initState();
    _playerRedScore = 0;
    _playerBlueScore = 0;
    myAirHockeyGame = AirHockeyGame();
    myAirHockeyGame.paused = false;
    myAirHockeyGame.PlayreScored = PlayreScored;
    myAirHockeyGame.NewGame = NewGame;
  }

  @override
  Widget build(BuildContext context) {
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
              overlayBuilderMap: const{
                'PauseMenu': pauseMenuBuilder,
                'FaceoffMenu': faceoffMenuBuilder,
                'WinnerMenu': winnerMenuBuilder,
              },
              backgroundBuilder: (context) => Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/air_hockey_rink.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
