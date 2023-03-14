import 'package:animated_play_button/animated_play_button.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedPlayButton(onPressed: () {  },pauseIconColor: Colors.black,),
      ),
    );
  }
}
