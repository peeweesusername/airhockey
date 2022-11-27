import 'package:air_hockey/playerpaddle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:air_hockey/airhockeygame.dart';

Widget pauseMenuBuilder(BuildContext buildContext, AirHockeyGame game) {
  return Center(
    child: Container(
      width: 250,
      height: 250,
      color: Colors.transparent,
      child:  Center(
        child: Column (
          children: [
            GestureDetector(
                onTap: (){
                  game.overlays.remove('PauseMenu');
                  game.resumeEngine();
                },
                child: const Text('Keep Playing', style: TextStyle(fontSize: 24, color: Colors.white))),
            const Text('', style: TextStyle(fontSize: 24)),
            GestureDetector(
                onTap: (){
                  SystemNavigator.pop();
                },
                child: const Text('Exit Game', style: TextStyle(fontSize: 24, color: Colors.white))),
          ],
        ),
      ),
    ),
  );
}

Widget faceoffMenuBuilder(BuildContext buildContext, AirHockeyGame game) {
  return Center(
    child: Container(
      width: 250,
      height: 250,
      color: Colors.transparent,
      child:  Center(
        child: Column (
          children: [
            Text('Red Team: '  + game.redscore.toString(), style: TextStyle(fontSize: 24, color: Colors.white)),
            const Text('', style: TextStyle(fontSize: 12)),
            Text('Blue Team: '  + game.bluescore.toString(), style: TextStyle(fontSize: 24, color: Colors.white)),
            const Text('', style: TextStyle(fontSize: 24)),
            GestureDetector(
                onTap: (){
                  game.overlays.remove('FaceoffMenu');
                  game.resumeEngine();
                  game.puckDrop();
                },
                child: const Text('Puck Drop', style: TextStyle(fontSize: 24, color: Colors.white))),
            const Text('', style: TextStyle(fontSize: 12)),
            GestureDetector(
                onTap: (){
                  SystemNavigator.pop();
                },
                child: const Text('Exit Game', style: TextStyle(fontSize: 24, color: Colors.white))),
          ],
        ),
      ),
    ),
  );
}

Widget winnerMenuBuilder(BuildContext buildContext, AirHockeyGame game) {
  Text  winnerText;
  if (game.theWinner == PlayerColor.redPlayer) {
    winnerText =  Text('Team Red Wins!', style: TextStyle(fontSize: 24, color: Colors.white));
  }
  else {
    winnerText = Text('Team Blue Wins!', style: TextStyle(fontSize: 24, color: Colors.white));
  }
  return Center(
    child: Container(
      width: 250,
      height: 250,
      color: Colors.transparent,
      child:  Center(
        child: Column (
          children: [
            winnerText,
            const Text('', style: TextStyle(fontSize: 24)),
            GestureDetector(
                onTap: (){
                  game.overlays.remove('WinnerMenu');
                  game.resumeEngine();
                  game.NewGame();
                },
                child: const Text('New Game', style: TextStyle(fontSize: 24, color: Colors.white))),
            const Text('', style: TextStyle(fontSize: 12)),
            GestureDetector(
                onTap: (){
                  SystemNavigator.pop();
                },
                child: const Text('Exit Game', style: TextStyle(fontSize: 24, color: Colors.white))),
          ],
        ),
      ),
    ),
  );
}
