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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: GestureDetector(
          onHorizontalDragStart: (DragStartDetails details) {
            print(details.globalPosition);
          },
          onHorizontalDragCancel: () {

          },
          onHorizontalDragDown: (DragDownDetails details) {},
          onHorizontalDragUpdate: (DragUpdateDetails details) {
            print(details.globalPosition);
          },
          onHorizontalDragEnd: (DragEndDetails details) {
            print(details.velocity);
          },
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.red,
                child: Center(
                  child: Text("A"),
                ),
              ),
              Container(
                color: Colors.blue,
                child: Center(
                  child: Text("B"),
                ),
              )
            ],
          ),
        ));
  }
}
