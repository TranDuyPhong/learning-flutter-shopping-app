import 'package:flutter/material.dart';

class GirliesMessages extends StatefulWidget {
    @override 
    State<StatefulWidget> createState() => new _GirliesMessagesState();
}

class _GirliesMessagesState extends State<GirliesMessages> {
    @override 
    Widget build(BuildContext buildContext) {
        return new Scaffold(
            appBar: new AppBar(
                title: new Text('My Messages'),
                centerTitle: false,
            ),
            body: new Center(
                child: new Text(
                    'My Messages',
                    style: new TextStyle(
                        fontSize: 25.0
                    )
                ),
            ),
        );
    }
} 