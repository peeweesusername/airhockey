
import 'dart:async';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:air_hockey/airHockeyStatefull.dart';

//TODO:
//5) Limit puck speed.

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