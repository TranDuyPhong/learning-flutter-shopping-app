import 'package:flutter/material.dart';

class GirliesNotifications extends StatefulWidget {
    @override 
    State<StatefulWidget> createState() => new _GirliesNotificationsState();
}

class _GirliesNotificationsState extends State<GirliesNotifications> {
    @override 
    Widget build(BuildContext buildContext) {
        return new Scaffold(
            appBar: new AppBar(
                title: new Text('My Notifications'),
                centerTitle: false,
            ),
            body: new Center(
                child: new Text(
                    'My Notifications',
                    style: new TextStyle(
                        fontSize: 25.0
                    )
                ),
            ),
        );
    }
} 