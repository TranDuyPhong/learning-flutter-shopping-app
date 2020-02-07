import 'package:flutter/material.dart';

class GirliesFavorites extends StatefulWidget {
    @override 
    State<StatefulWidget> createState() => new _GirliesFavoritesState();
}

class _GirliesFavoritesState extends State<GirliesFavorites> {
    @override 
    Widget build(BuildContext buildContext) {
        return new Scaffold(
            appBar: new AppBar(
                title: new Text('My Favorites'),
                centerTitle: false,
            ),
            body: new Center(
                child: new Text(
                    'My Favorites',
                    style: new TextStyle(
                        fontSize: 25.0
                    )
                ),
            ),
        );
    }
} 