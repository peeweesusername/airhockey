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
        _playerRedScore++;
      }
      else {
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
            //TODO: this no working, background image is black
            //Suspect due to default background of game is black.
            //Try the backgroundBuilder below.
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/air_hockey_rink.png'),
                fit: BoxFit.cover,
                ),
              ),
            child: GameWidget<AirHockeyGame>(
              game: myAirHockeyGame,
              overlayBuilderMap: const{
                'PauseMenu': pauseMenuBuilder,
                'FaceoffMenu': faceoffMenuBuilder,
                'WinnerMenu': winnerMenuBuilder,
              },
              //TODO: figure out how to use this to add rink background image
              //backgroundBuilder: ,
            ),
          ),
          ],
        ),
      ),
    );
  }
}
