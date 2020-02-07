import 'package:flutter/material.dart';

class GirliesDelivery extends StatefulWidget {
    @override 
    State<StatefulWidget> createState() => new _GirliesDeliveryState();
}

class _GirliesDeliveryState extends State<GirliesDelivery> {
    @override 
    Widget build(BuildContext buildContext) {
        return new Scaffold(
            appBar: new AppBar(
                title: new Text('My Delivery'),
                centerTitle: false,
            ),
            body: new Center(
                child: new Text(
                    'My Delivery',
                    style: new TextStyle(
                        fontSize: 25.0
                    )
                ),
            ),
        );
    }
} 