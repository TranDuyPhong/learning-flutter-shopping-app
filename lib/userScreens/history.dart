import 'package:flutter/material.dart';

class GirliesHistory extends StatefulWidget {
    @override 
    State<StatefulWidget> createState() => new _GirliesHistoryState();
}

class _GirliesHistoryState extends State<GirliesHistory> {
    @override 
    Widget build(BuildContext buildContext) {
        return new Scaffold(
            appBar: new AppBar(
                title: new Text('My History'),
                centerTitle: false,
            ),
            body: new Center(
                child: new Text(
                    'My History',
                    style: new TextStyle(
                        fontSize: 25.0
                    )
                ),
            ),
        );
    }
} 