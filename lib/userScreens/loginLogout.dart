import 'package:flutter/material.dart';

import 'package:shoppingapp/tools/app_methods.dart';
import 'package:shoppingapp/tools/app_tools.dart';
import 'package:shoppingapp/tools/firebase_methods.dart';
import 'package:shoppingapp/userScreens/signup.dart';
import 'package:shoppingapp/tools/app_data.dart';

class GirliesLoginLogout extends StatefulWidget {
    @override 
    State<StatefulWidget> createState() => new _GirliesLoginLogoutState();
}

class _GirliesLoginLogoutState extends State<GirliesLoginLogout> {
    TextEditingController email = new TextEditingController();
    TextEditingController password = new TextEditingController();

    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

    BuildContext buildContext;

    AppMethods appMethods = new FirebaseMethods();

    verifyLogin() async {
        if (email.text == '') {
            showSnackBar('Email cannot be empty', scaffoldKey);
            return;
        }
        if (password.text == '') {
            showSnackBar('Password cannot be empty', scaffoldKey);
            return;
        }

        displayProgressDialog(buildContext);

        String response = await appMethods.loginUser(email: email.text.toLowerCase(), password: password.text.toLowerCase());

        if (response == successful) {
            closeProgressDialog(buildContext);
            Navigator.of(context).pop(true);
        } else {
            closeProgressDialog(buildContext);
            showSnackBar(response == null ? '' : response, scaffoldKey);
        }
    }

    @override 
    Widget build(BuildContext buildContext) {
        this.buildContext = buildContext;
        return new Scaffold(
            key: scaffoldKey,
            backgroundColor: Theme.of(context).primaryColor,
            appBar: new AppBar(
                title: new Text('My Login Logout'),
                centerTitle: false,
                elevation: 0.0,
            ),
            body: new SingleChildScrollView(
                child: new Column(
                    children: <Widget>[
                        new SizedBox(
                            height: 30.0,
                        ),
                        appTextField(
                            isPassword: false,
                            sizePadding: 18.0,
                            textHint: 'Email Address',
                            textIcon: Icons.email,
                            controller: email,
                            textType: TextInputType.emailAddress
                        ),
                        new SizedBox(
                            height: 30.0,
                        ),
                        appTextField(
                            isPassword: true,
                            sizePadding: 18.0,
                            textHint: 'Password',
                            textIcon: Icons.lock,
                            controller: password
                        ),
                        appButton(
                            btnTxt: 'Login',
                            btnPadding: 18.0,
                            btnColor: Theme.of(context).primaryColor,
                            onBtnClicked: verifyLogin
                        ),
                        new GestureDetector(
                            onTap: () {
                                final pageRoute = new MaterialPageRoute(
                                    builder: (context) {
                                        return new GirliesSignUp();
                                    }
                                );
                                Navigator.push(context, pageRoute);
                            },
                            child: new Text(
                                'Not Registerd ? Sign Up Here',
                                style: new TextStyle(
                                    color: Colors.white
                                ),
                            ),
                        )
                    ],
                ),
            )
        );
    }
} 