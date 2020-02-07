import 'package:flutter/material.dart';

class AppOrders extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => new _AppOrdersState();
}

class _AppOrdersState extends State<AppOrders> {
    @override
    Widget build(BuildContext buildContext) {
        return new Scaffold(
            appBar: new AppBar(
                title: new Text('App Orders'),
                centerTitle: false,
            ),
            body: new Center(
                child: new Text(
                    'App Orders',
                    style: new TextStyle(
                        fontSize: 25.0
                    ),
                ),
            ),
        );
    }
}