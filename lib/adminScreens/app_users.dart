import 'package:flutter/material.dart';

class AppUsers extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => new _AppUsersState();
}

class _AppUsersState extends State<AppUsers> {
    @override
    Widget build(BuildContext buildContext) {
        return new Scaffold(
            appBar: new AppBar(
                title: new Text('App Users'),
                centerTitle: false,
            ),
            body: new Center(
                child: new Text(
                    'App Users',
                    style: new TextStyle(
                        fontSize: 25.0
                    ),
                ),
            ),
        );
    }
}