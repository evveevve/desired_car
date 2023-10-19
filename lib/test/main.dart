import 'package:flutter/material.dart';
import 'fade_in_from_bottom.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget  {
  final List<Widget> children = <Widget>[
    
    Container(
      height: 32.0,
      color: Colors.black,
    ),
    Container(
      height: 32.0,
      color: Colors.purple,
    ),
    Container(
      height: 32.0,
      color: Colors.green,
    ),
    Container(
      height: 32.0,
      color: Colors.indigo,
    ),
    Container(
      height: 32.0,
      color: Colors.amber,
    ),
    Container(
      height: 32.0,
      color: Colors.black,
    ),
    Container(
      height: 32.0,
      color: Colors.purple,
    ),
    Container(
      height: 32.0,
      color: Colors.green,
    ),
    Container(
      height: 32.0,
      color: Colors.indigo,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: children,
        // mainAxisAlignment: MainAxisAlignment.center,
        // children: <Widget>[
        //   Expanded(
        //     child: ListView.builder(
        //       itemCount: children.length,
        //       itemBuilder: (BuildContext context, int index) {
        //         return FadeInFromBottom(
        //           key: UniqueKey(), // this is very important
        //           index: index,
        //           child: children[index],
        //         );
        // },

        // ),
        // ],
      ),
    );
  }
}
