import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';

import 'package:shoppingapp/tools/progressdialog.dart';

Widget appTextField({ IconData textIcon, String textHint, bool isPassword, TextEditingController controller, double sizePadding, TextInputType textType }) {
    sizePadding = sizePadding == null ? 0.0 : sizePadding;
    textType = textType == null ? TextInputType.text : textType;
    isPassword = isPassword == null ? false : isPassword;
    textHint = textHint == null ? '' : textHint;

    return Padding(
        padding: new EdgeInsets.only(
            left: sizePadding,
            right: sizePadding
        ),
        child: new Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(
                    new Radius.circular(15.0)
                ),
            ),
            child: new TextField(
                controller: controller,
                obscureText: isPassword,
                keyboardType: textType,
                decoration: new InputDecoration(
                    hintText: textHint,
                    prefixIcon: textIcon == null ? new Container() : new Icon(textIcon),
                    border: InputBorder.none
                )
            ),
        ),
    );
}

Widget productTextFiled({ String titleText, String textHint, double height, TextEditingController controller, TextInputType textType, int maxLines }) {
    textHint = textHint == null ? 'Enter Hint' : textHint;
    height = height == null ? 50.0 : height;
    titleText = titleText == null ? 'Enter Title' : titleText;
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                    titleText,
                    style: new TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                    ),
                ),
            ),
            new Padding(
                padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0
                ),
                child: new Container(
                    height: height,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        border: new Border.all(
                            color: Colors.white
                        ),
                        borderRadius: new BorderRadius.all(
                            new Radius.circular(4.0)
                        )
                    ),
                    child: new Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0
                        ),
                        child: new TextField(
                            controller: controller,
                            keyboardType: textType,
                            maxLines: maxLines == null ? null : maxLines,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: textHint
                            ),
                        ),
                    ),
                ),
            )
        ],
    );
}

Widget productDropDown({ String titleText, double height, String selected, List<DropdownMenuItem<String>> items, ValueChanged<String> onChange }) {
    height = height == null ? 50.0 : height;
    titleText = titleText == null ? '' : titleText;
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                    titleText,
                    style: new TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                    ),
                ),
            ),
            new Padding(
                padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0
                ),
                child: new Container(
                    height: height,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        border: new Border.all(
                            color: Colors.white
                        ),
                        borderRadius: new BorderRadius.all(
                            new Radius.circular(4.0)
                        )
                    ),
                    child: new Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 15.0
                        ),
                        child: new DropdownButtonHideUnderline(
                            child: new DropdownButton(
                                value: selected,
                                items: items,
                                onChanged: onChange
                            )
                        )
                    )
                ),
            )
        ],
    );
}

Widget appButton({ String btnTxt, double btnPadding, Color btnColor, VoidCallback onBtnClicked }) {
    btnTxt = btnTxt == null ? 'App Button' : btnTxt;
    btnPadding = btnPadding == null ? 0.0 : btnPadding;
    btnColor = btnColor == null ? Colors.black : btnColor;
    
    return new Padding(
        padding: new EdgeInsets.all(btnPadding),
        child: new RaisedButton(
            color: Colors.white,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.all(
                    new Radius.circular(15.0)
                )
            ),
            onPressed: onBtnClicked,
            child: new Container(
                height: 50.0,
                child: new Center(
                    child: new Text(
                        btnTxt,
                        style: new TextStyle(
                            color: btnColor,
                            fontSize: 18.0
                        ),
                    ),
                ),
            )
        ),
    );
}

Widget multiImagePickerList({ List<File> images, VoidCallback remove(int position) }) {
    return new Padding(
        padding: const EdgeInsets.only(
            left: 15.0,
            right: 15.0
        ),
        child: images == null || images.length == 0 ? 
            new Container() : 
            new SizedBox(
                height: 150.0,
                child: new ListView.builder(
                    itemCount: images.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                        return new Padding(
                            padding: const EdgeInsets.only(
                                left: 3.0,
                                right: 3.0
                            ),
                            child: new Stack(
                                children: <Widget>[
                                    new Container(
                                        width: 150.0,
                                        height: 150.0,
                                        decoration: new BoxDecoration(
                                            color: Colors.grey.withAlpha(100),
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(15.0)
                                            ),
                                            image: new DecorationImage(
                                                image: new FileImage(images[index]),
                                                fit: BoxFit.cover
                                            )
                                        )
                                    ),
                                    new Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: new CircleAvatar(
                                            backgroundColor: Colors.red[600],
                                            child: new IconButton(
                                                icon: new Icon(
                                                    Icons.clear,
                                                    color: Colors.white,
                                                ),
                                                onPressed: () {
                                                    remove(index);
                                                },
                                            )
                                        ),
                                    )
                                ]
                            ),
                        );
                    }
                )
            ),
    );
}

showSnackBar(String message, GlobalKey<ScaffoldState> scaffoldKey) {
    SnackBar snackbar = new SnackBar(
        backgroundColor: Colors.red[600],
        content: new Text(
            message,
            style: new TextStyle(
                color: Colors.white
            ),
        ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
}

displayProgressDialog(BuildContext buildContext) {
    final pageRoute = new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
            return new ProgressDialog();
        }
    );

    Navigator.of(buildContext).push(pageRoute);
}

closeProgressDialog(BuildContext buildContext) {
    Navigator.of(buildContext).pop();
}

writeDataLocally({ String key, String value }) async {
    Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
    final SharedPreferences shared = await sharedPreferences;
    shared.setString(key, value);
}

writeBoolDataLocally({ String key, bool value }) async {
    Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
    final SharedPreferences shared = await sharedPreferences;
    shared.setBool(key, value);
}

getDataLocally({ String key }) async {
    Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
    final SharedPreferences shared = await sharedPreferences;
    return shared.get(key);
}

getStringDataLocally({ String key }) async {
    Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
    final SharedPreferences shared = await sharedPreferences;
    return shared.getString(key);
}

getBoolDataLocally({ String key }) async {
    Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
    final SharedPreferences shared = await sharedPreferences;
    return shared.getBool(key);
}

clearDataLocally() async {
    Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
    final SharedPreferences shared = await sharedPreferences;
    await shared.clear();
}
