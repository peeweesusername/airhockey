
import 'dart:async';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:air_hockey/airHockeyStatefull.dart';

//TODO:
//1) Fix assert - if both paddles are not dragged prior to first score:
//'package:forge2d/src/dynamics/world.dart': Failed assertion: line 160 pos 12: '!isLocked': is not true.
//2) Limit puck speed.

void main() async {
  //Make sure flame is ready before we launch our game
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await setupFlame();
  runApp(AirHockeyApp());
}

class AirHockeyApp extends StatelessWidget {
  const AirHockeyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      home: AirHockeyGameStatefull(),
    );
  }
}

/// Setup all Flame specific parts
Future setupFlame() async {
  await Flame.device.fullScreen();
  await Flame.device.setOrientation(DeviceOrientation.portraitUp);
}