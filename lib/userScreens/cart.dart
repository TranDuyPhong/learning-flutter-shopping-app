import 'package:flutter/material.dart';

class GirliesCart extends StatefulWidget {
    @override 
    State<StatefulWidget> createState() => new _GirliesCartState();
}

class _GirliesCartState extends State<GirliesCart> {
    @override 
    Widget build(BuildContext buildContext) {
        return new Scaffold(
            appBar: new AppBar(
                title: new Text('My Cart'),
                centerTitle: false,
            ),
            body: new Center(
                child: new Text(
                    'My Cart',
                    style: new TextStyle(
                        fontSize: 25.0
                    )
                ),
            ),
        );
    }
} 