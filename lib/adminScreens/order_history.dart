import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => new _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
    @override
    Widget build(BuildContext buildContext) {
        return new Scaffold(
            appBar: new AppBar(
                title: new Text('Order History'),
                centerTitle: false,
            ),
            body: new Center(
                child: new Text(
                    'Order History',
                    style: new TextStyle(
                        fontSize: 25.0
                    ),
                ),
            ),
        );
    }
}