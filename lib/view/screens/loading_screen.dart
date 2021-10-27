import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timesofindia/view/screen_config_constants.dart';
import 'package:timesofindia/view/screens/home_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? gridHeight, gridWidth;
  //Timer t1 = Timer.periodic(const Duration(seconds: 10), (timer) {});
  @override
  void initState() {
    if (!mounted) {
      return;
    }
    Timer.periodic(const Duration(seconds: 3), (timer) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyHomePage()));
      timer.cancel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig().read(context);
    gridHeight = ScreenConfig.gridHeight;
    gridWidth = ScreenConfig.gridWidth;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              height: gridHeight! * 100,
              width: gridWidth! * 100,
              child: Column(
                children: [
                  const Expanded(child: SizedBox()),
                  SizedBox(
                    height: gridHeight! * 30,
                    width: gridWidth! * 100,
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                      height: gridHeight! * 10,
                      width: gridWidth! * 100,
                      child: const Center(child: CircularProgressIndicator())),
                  const Expanded(child: SizedBox()),
                ],
              ),
            )));
  }
}
