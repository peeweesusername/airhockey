import 'package:air_hockey/playerpaddle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:air_hockey/airhockeygame.dart';

Widget pauseMenuBuilder(BuildContext buildContext, AirHockeyGame game) {
  return Center(
    child: Container(
      color: Colors.transparent,
      child:  Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: (){
                  game.overlays.remove('PauseMenu');
                  game.resumeEngine();
                },
                child: const Text('Keep Playing', style: TextStyle(fontSize: 24, color: Colors.black))),
            const Text('', style: TextStyle(fontSize: 24)),
            GestureDetector(
                onTap: (){
                  SystemNavigator.pop();
                },
                child: const Text('Exit Game', style: TextStyle(fontSize: 24, color: Colors.black))),
          ],
        ),
      ),
    ),
  );
}

Widget faceoffMenuBuilder(BuildContext buildContext, AirHockeyGame game) {
  Text  whoScoredText;
  if (game.whoScored == PlayerColor.redPlayer) {
    whoScoredText =  const Text('Team Red Scores!\n', style: TextStyle(fontSize: 24, color: Colors.black));
  }
  else {
    whoScoredText = const Text('Team Blue Scores!\n', style: TextStyle(fontSize: 24, color: Colors.black));
  }

  return Center(
    child: Container(
      color: Colors.transparent,
      child:  Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (game.whoScored != PlayerColor.noPlayer)
              whoScoredText,
            Text('Red Team: ${game.redscore}', style: const TextStyle(fontSize: 24, color: Colors.black)),
            const Text('', style: TextStyle(fontSize: 12)),
            Text('Blue Team: ${game.bluescore}', style: const TextStyle(fontSize: 24, color: Colors.black)),
            const Text('', style: TextStyle(fontSize: 24)),
            GestureDetector(
                onTap: (){
                  game.overlays.remove('FaceoffMenu');
                  game.resumeEngine();
                  game.puckDrop();
                },
                child: const Text('Puck Drop', style: TextStyle(fontSize: 24, color: Colors.black))),
            const Text('', style: TextStyle(fontSize: 12)),
            GestureDetector(
                onTap: (){
                  SystemNavigator.pop();
                },
                child: const Text('Exit Game', style: TextStyle(fontSize: 24, color: Colors.black))),
          ],
        ),
      ),
    ),
  );
}

Widget winnerMenuBuilder(BuildContext buildContext, AirHockeyGame game) {
  Text  winnerText;
  if (game.theWinner == PlayerColor.redPlayer) {
    winnerText =  const Text('Team Red Wins!', style: TextStyle(fontSize: 24, color: Colors.black));
  }
  else {
    winnerText = const Text('Team Blue Wins!', style: TextStyle(fontSize: 24, color: Colors.black));
  }
  return Center(
    child: Container(
      color: Colors.transparent,
      child:  Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            winnerText,
            const Text('', style: TextStyle(fontSize: 24)),
            GestureDetector(
                onTap: (){
                  game.overlays.remove('WinnerMenu');
                  game.resumeEngine();
                  game.NewGame();
                },
                child: const Text('New Game', style: TextStyle(fontSize: 24, color: Colors.black))),
            const Text('', style: TextStyle(fontSize: 12)),
            GestureDetector(
                onTap: (){
                  SystemNavigator.pop();
                },
                child: const Text('Exit Game', style: TextStyle(fontSize: 24, color: Colors.black))),
          ],
        ),
      ),
    ),
  );
}
