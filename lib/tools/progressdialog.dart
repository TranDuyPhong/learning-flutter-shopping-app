import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
    @override 
    Widget build(BuildContext buildContext) {
        return new Material(
            color: Colors.black.withAlpha(200),
            child: new Center(
                child: new Container(
                    padding: const EdgeInsets.all(30.0),
                    child: new GestureDetector(
                        onTap: () {
                            Navigator.pop(buildContext);
                        },
                        child: new Center(
                            child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    new CircularProgressIndicator(),
                                    new SizedBox(
                                        height: 15.0,
                                    ),
                                    new Text(
                                        'Please wait...',
                                        style: new TextStyle(
                                            color: Colors.blue
                                        )
                                    )
                                ],
                            ),
                        ),
                    ),
                ),
            ),
        );
    }
}