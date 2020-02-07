import 'package:flutter/material.dart';

class AppProducts extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => new _AppProductsState();
}

class _AppProductsState extends State<AppProducts> {
    @override
    Widget build(BuildContext buildContext) {
        return new Scaffold(
            appBar: new AppBar(
                title: new Text('App Products'),
                centerTitle: false,
            ),
            body: new Center(
                child: new Text(
                    'App Products',
                    style: new TextStyle(
                        fontSize: 25.0
                    ),
                ),
            ),
        );
    }
}