import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/game.dart';
import 'package:air_hockey/airhockeygame.dart';

Widget _menuBuilder(BuildContext buildContext, AirHockeyGame game) {
  return Center(
    child: Container(
      width: 200,
      height: 100,
      color: Colors.black,
      child:  Center(
        child: Column (
          children: [
            GestureDetector(
                onTap: (){
                  game.overlays.remove('Menu');
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

/*
Widget airHockeyStatefull() {
  return GameWidget<AirHockeyGame>(
    game: AirHockeyGame()..paused = false,
    overlayBuilderMap: const {
      'Menu': _menuBuilder,
    },
  );
}
*/

class airHockeyStatefull extends StatefulWidget {
  const airHockeyStatefull({super.key});
  @override
  State<airHockeyStatefull> createState() => _airHockeyStatefull();
}

class _airHockeyStatefull extends State<airHockeyStatefull> {
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
              game: AirHockeyGame()..paused = false,
              overlayBuilderMap: const
                {'Menu': _menuBuilder,},
            ),
          )
          ],
        ),
      ),
    );
  }
}
