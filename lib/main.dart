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
      home: MyHomePage(title: 'flutter 3d sideslip menu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Offset _horizontalDragStart;
  AnimationController _sideAnimController;

  @override
  void initState() {
    super.initState();

    _sideAnimController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _sideAnimController.dispose();
    super.dispose();
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    _horizontalDragStart = details.globalPosition;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if(_sideAnimController.isAnimating)
      return;
    _sideAnimController.value +=
        details.primaryDelta/(MediaQuery.of(context).size.width??details.primaryDelta);
//    details.primaryDelta/(MediaQuery.of(context).size.width??details.primaryDelta)
//    print(_sideAnimController.value);
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    _horizontalDragStart = null;
    if(_sideAnimController.isCompleted){
      return;
    }
    if(details.primaryVelocity > 0){
      _sideAnimController.forward();
    }else{
      _sideAnimController.reverse();
    }
//    print(details.primaryVelocity );

  }

  Animation<double> _scaleRect() {
    return Tween<double>(begin: 1.5, end: 1).animate(_sideAnimController);
  }

  Animation<RelativeRect> _offsetRect() {
    double width = MediaQuery.of(context).size.width;
//    return Tween<RelativeRect>(
//            begin: RelativeRect.fromLTRB(0, 0, 0, 0),
//            end: RelativeRect.fromLTRB(width - 80, 0, 80 - width, 0))
//        .animate(_sideAnimController);
  return RelativeRectTween( begin: RelativeRect.fromLTRB(0, 0, 0, 0),
         end: RelativeRect.fromLTRB(width - 80, 0, 80 - width, 0)).animate(_sideAnimController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragStart: _onHorizontalDragStart,
            onHorizontalDragUpdate: _onHorizontalDragUpdate,
            onHorizontalDragEnd: _onHorizontalDragEnd,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Stack(
                  children: <Widget>[
                    ScaleTransition(
                      scale: _scaleRect(),
                      child: Container(
                        color: Colors.blue,
                        child: Center(
                          child: Text("B"),
                        ),
                      ),
                    ),
                    PositionedTransition(
                      rect: _offsetRect(),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.red,
                        child: Center(
                          child: Text("A"),
                        ),
                      ),
                    )
                  ],
                );
              },
            )));
  }
}
