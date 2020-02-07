import 'package:flutter/material.dart';

class GirliesAboutUs extends StatefulWidget {
    @override 
    State<StatefulWidget> createState() => new _GirliesAboutUsState();
}

class _GirliesAboutUsState extends State<GirliesAboutUs> {
    @override 
    Widget build(BuildContext buildContext) {
        return new Scaffold(
            appBar: new AppBar(
                title: new Text('My About Us'),
                centerTitle: false,
            ),
            body: new Center(
                child: new Text(
                    'My About Us',
                    style: new TextStyle(
                        fontSize: 25.0
                    )
                ),
            ),
        );
    }
} 