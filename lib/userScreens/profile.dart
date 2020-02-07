import 'package:flutter/material.dart';

class GirliesProfile extends StatefulWidget {
    @override 
    State<StatefulWidget> createState() => new _GirliesProfileState();
}

class _GirliesProfileState extends State<GirliesProfile> {
    @override 
    Widget build(BuildContext buildContext) {
        return new Scaffold(
            appBar: new AppBar(
                title: new Text('My Profile'),
                centerTitle: false,
            ),
            body: new Center(
                child: new Text(
                    'My Profile',
                    style: new TextStyle(
                        fontSize: 25.0
                    )
                ),
            ),
        );
    }
} 