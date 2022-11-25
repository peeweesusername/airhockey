import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:air_hockey/airhockeygame.dart';

Widget pauseMenuBuilder(BuildContext buildContext, AirHockeyGame game) {
  return Center(
    child: Container(
      width: 200,
      height: 100,
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
      width: 200,
      height: 100,
      color: Colors.transparent,
      child:  Center(
        child: Column (
          children: [
            GestureDetector(
                onTap: (){
                  game.overlays.remove('FaceoffMenu');
                  game.resumeEngine();
                  game.puckDrop();
                },
                child: const Text('Puck Drop', style: TextStyle(fontSize: 24, color: Colors.white))),
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
