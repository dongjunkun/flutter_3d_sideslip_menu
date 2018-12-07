import 'dart:math' show pi;

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _sideAnimController;

  @override
  void initState() {
    super.initState();
    _sideAnimController =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _sideAnimController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              if (_sideAnimController.isAnimating) return;
              _sideAnimController.value += details.primaryDelta /
                  (MediaQuery.of(context).size.width ?? details.primaryDelta);
            },
            onHorizontalDragEnd: (DragEndDetails details) {
              if (_sideAnimController.isCompleted) {
                return;
              }
              if (details.primaryVelocity > 1) {
                _sideAnimController.forward();
              } else if (details.primaryVelocity < -1) {
                _sideAnimController.reverse();
              } else {
                if (_sideAnimController.value >= 0.5) {
                  _sideAnimController.forward();
                } else {
                  _sideAnimController.reverse();
                }
              }
            },
            onScaleUpdate: (ScaleUpdateDetails details){
            },
            child: Stack(
              children: <Widget>[
                Transform.scale(
                  alignment: Alignment.centerRight,
                  scale: 1.5 - _sideAnimController.value * 0.5,
                  child: Container(
                    height: height,
                    width: width,
                    child: Image.asset(
                      'images/stars.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.005)
                    ..translate(_sideAnimController.value * (width - 80), 0, 0)
                    ..rotateY(pi * _sideAnimController.value * 0.05)
                    ..scale(1 - _sideAnimController.value * 0.15),
                  child: Container(
                    height: height,
                    width: width,
                    child: Image.asset(
                      'images/balloon.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            )));
  }
}
