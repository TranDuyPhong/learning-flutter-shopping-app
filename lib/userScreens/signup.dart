import 'package:flutter/material.dart';

import 'package:shoppingapp/tools/app_methods.dart';
import 'package:shoppingapp/tools/app_tools.dart';
import 'package:shoppingapp/tools/firebase_methods.dart';
import 'package:shoppingapp/tools/app_data.dart';

class GirliesSignUp extends StatefulWidget {
    @override 
    State<StatefulWidget> createState() => new _GirliesSignUpState();
}

class _GirliesSignUpState extends State<GirliesSignUp> {
    TextEditingController fullName = new TextEditingController();
    TextEditingController phoneNumber = new TextEditingController();
    TextEditingController email = new TextEditingController();
    TextEditingController password = new TextEditingController();
    TextEditingController rePassword = new TextEditingController();

    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

    BuildContext buildContext;
    
    AppMethods appMethods = new FirebaseMethods();

    verifyDetails() async {
        if (fullName.text == '') {
            showSnackBar('Full name cannot be empty', scaffoldKey);
            return;
        }
        if (phoneNumber.text == '') {
            showSnackBar('Phone number cannot be empty', scaffoldKey);
            return;
        }
        if (email.text == '') {
            showSnackBar('Email cannot be empty', scaffoldKey);
            return;
        }
        if (password.text == '') {
            showSnackBar('Password cannot be empty', scaffoldKey);
            return;
        }
        if (rePassword.text != password.text) {
            showSnackBar('Re-Password don\'t match', scaffoldKey);
            return;
        }   

        displayProgressDialog(buildContext);

        String response = await appMethods.createUserAccount(
            email: email.text,
            password: password.text,
            fullName: fullName.text,
            phoneNumber: phoneNumber.text,
        );

        if (response == successful) {
            closeProgressDialog(buildContext);
            Navigator.of(context).pop();
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
                title: new Text('My Sign Up'),
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
                            textHint: 'Full Name',
                            textIcon: Icons.person,
                            controller: fullName,
                        ),
                        new SizedBox(
                            height: 30.0,
                        ),
                        appTextField(
                            isPassword: false,
                            sizePadding: 18.0,
                            textHint: 'Phone Number',
                            textIcon: Icons.phone,
                            controller: phoneNumber,
                            textType: TextInputType.phone
                        ),
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
                        new SizedBox(
                            height: 30.0,
                        ),
                        appTextField(
                            isPassword: true,
                            sizePadding: 18.0,
                            textHint: 'Re-Password',
                            textIcon: Icons.lock,
                            controller: rePassword
                        ),
                        appButton(
                            btnTxt: 'Create Account',
                            btnPadding: 18.0,
                            btnColor: Theme.of(context).primaryColor,
                            onBtnClicked: verifyDetails
                        )
                    ],
                ),
            )
        );
    }
} 