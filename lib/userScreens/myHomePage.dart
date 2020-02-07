import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/adminScreens/admin_home.dart';

import 'package:shoppingapp/tools/app_methods.dart';
import 'package:shoppingapp/tools/app_tools.dart';
import 'package:shoppingapp/tools/firebase_methods.dart';
import 'package:shoppingapp/userScreens/aboutUs.dart';
import 'package:shoppingapp/userScreens/cart.dart';
import 'package:shoppingapp/userScreens/delivery.dart';
import 'package:shoppingapp/userScreens/history.dart';
import 'package:shoppingapp/userScreens/itemDetails.dart';
import 'package:shoppingapp/userScreens/loginLogout.dart';
import 'package:shoppingapp/userScreens/messages.dart';
import 'package:shoppingapp/userScreens/favorites.dart';
import 'package:shoppingapp/userScreens/notifications.dart';
import 'package:shoppingapp/userScreens/profile.dart';
import 'package:shoppingapp/tools/app_data.dart';
import 'package:shoppingapp/tools/Store.dart';

class MyHomePage extends StatefulWidget {
    @override 
    State<StatefulWidget> createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    AppMethods appMethods = new FirebaseMethods();

    BuildContext buildContext;
    String acctName = 'Guest User';
    String acctPhotoURL = 'Guest Avatar';
    String acctEmail = 'guestUser@email.com';
    bool isLoggedIn = false;

    Firestore firestore = Firestore.instance;

    @override
    void initState() {  
        super.initState();
        getCurrentUser();
    }   

    Future<void> getCurrentUser() async {
        this.acctName = await getStringDataLocally(key: userFullName);
        this.acctEmail = await getStringDataLocally(key: userEmail);
        this.acctPhotoURL = await getStringDataLocally(key: userPhotoURL);
        this.isLoggedIn = await getBoolDataLocally(key: userLoggedIn);

        this.acctName = this.acctName == null ? 'Guest User' : this.acctName;
        this.acctEmail = this.acctEmail == null ? 'guestUser@email.com' : this.acctEmail;
        this.acctPhotoURL = this.acctPhotoURL == null ? 'Guest Avatar' : this.acctPhotoURL;
        this.isLoggedIn = this.isLoggedIn == null ? false : this.isLoggedIn;
        setState(() {});
    }

    checkIfLoggedIn() async {
        if (this.isLoggedIn == true) {
            bool response = await appMethods.logoutUser();
            if (response == true) {
                await getCurrentUser();
            }
        } else {
            final pageRouteGirliesLoginLogout = new CupertinoPageRoute(
                builder: (context) => new GirliesLoginLogout()
            );
            final response = await Navigator.push(context, pageRouteGirliesLoginLogout);
            if (response == true) {
                await getCurrentUser();
            }
        }
    }

    openAdmin() {
        final pageRouteAdmin = new MaterialPageRoute(
            builder: (BuildContext buildContext) => new AdminHome()
        );
        Navigator.of(context).push(pageRouteAdmin);
    }

    Widget noDataFound() {
        return new Container(
            child: new Center(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        new Icon(
                            Icons.find_in_page,
                            color: Colors.black45,
                            size: 80.0,
                        ),
                        new Text(
                            'Not Product avaliable yet.',
                            style: new TextStyle(
                                color: Colors.black45,
                                fontSize: 20.0
                            )
                        ),
                        new SizedBox(
                            height: 10.0,
                        ),
                        new Text(
                            'Please check back later',
                            style: new TextStyle(
                                color: Colors.red,
                                fontSize: 14.0
                            )
                        )
                    ]
                )
            ),
        );
    }

    Widget buildProducts(BuildContext context, int index, DocumentSnapshot document) {
        List images = document[productImages] as List;
        return new GestureDetector(
            onTap: () {
                final pageRouteGirliesItemDetails = new MaterialPageRoute(
                    builder: (context) => new GirliesItemDetails(
                        itemName: document[productTitle],
                        itemSubName: document[productDescription],
                        itemImage: images[0],
                        itemPrice: document[productPrice],
                        itemRating: '0.0',
                        itemImages: images
                    )
                );
                Navigator.of(context).push(pageRouteGirliesItemDetails);
            },
            child: new Card(
                child: new Stack(
                    alignment: FractionalOffset.topLeft,
                    children: <Widget>[
                        new Stack(
                            alignment: FractionalOffset.bottomCenter,
                            children: <Widget>[
                                new Container(
                                    decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                            fit: BoxFit.fitWidth,
                                            image: new NetworkImage(
                                                images[0]
                                            )
                                        )
                                    ),
                                ),
                                new Container(
                                    width: 150.0,
                                    height: 50.0,
                                    color: Colors.black.withAlpha(100),
                                    child: new Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                            new Text(
                                                '${document[productTitle].substring(0, 5)}...',
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16.0,
                                                    color: Colors.white
                                                ),
                                            ),
                                            new Text(
                                                'N${document[productPrice]}',
                                                style: new TextStyle(
                                                    color: Colors.red[500],
                                                    fontWeight: FontWeight.w700,
                                                ),
                                            )
                                        ],
                                    ),
                                )
                            ],
                        ),
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                new Container(
                                    height: 30.0,
                                    width: 60.0,
                                    decoration: new BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: new BorderRadius.only(
                                            topRight: new Radius.circular(5.0),
                                            bottomRight: new Radius.circular(5.0)
                                        ),
                                    ),
                                    child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                            new Icon(
                                                Icons.star,
                                                color: Colors.blue,
                                                size: 20.0,
                                            ),
                                            new Text(
                                                '0.0',
                                                style: new TextStyle(
                                                    color: Colors.white
                                                )
                                            )
                                        ],
                                    ),
                                ),
                                new IconButton(
                                    icon: new Icon(Icons.favorite_border),
                                    onPressed: () {

                                    },
                                    color: Colors.blue,
                                )
                            ],
                        )
                    ],
                ),
            ),
        );
    }

    @override 
    Widget build(BuildContext buildContext) {
        this.buildContext = buildContext;
        return new Scaffold(
            appBar: new AppBar(
                title: new GestureDetector(
                    onLongPress: openAdmin,
                    child: new Text('Girlies'),
                ),
                centerTitle: true,
                actions: <Widget>[
                    new IconButton(
                        icon: new Icon(Icons.favorite),
                        onPressed: () {
                            final pageRouteGirliesFavorites = new CupertinoPageRoute(
                                builder: (context) => new GirliesFavorites()
                            );
                            Navigator.of(context).push(pageRouteGirliesFavorites);
                        },
                    ),
                    new Stack(
                        alignment: Alignment.topLeft,
                        children: <Widget>[
                            new IconButton(
                                icon: new Icon(Icons.chat),
                                onPressed: () {
                                    final pageRouteGirliesMessages = new CupertinoPageRoute(
                                        builder: (context) => new GirliesMessages()
                                    );
                                    Navigator.of(context).push(pageRouteGirliesMessages);
                                },
                            ),
                            new CircleAvatar(
                                radius: 8.0,
                                backgroundColor: Colors.red,
                                child: new Text(
                                    '0',
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0
                                    ),
                                ),
                            )
                        ],
                    )
                ],
            ),
            floatingActionButton: new Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                    new FloatingActionButton(
                        onPressed: () {
                            final pageRouteGirliesCart = new CupertinoPageRoute(
                                builder: (context) => new GirliesCart()
                            );
                            Navigator.of(context).push(pageRouteGirliesCart);
                        },
                        child: new Icon(Icons.shopping_cart)
                    ),
                    new CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 10.0,
                        child: new Text(
                            '0',
                            style: new TextStyle(
                                fontSize: 12.0,
                                color: Colors.white
                            )
                        ),
                    )
                ],
            ),
            drawer: new Drawer(
                child: new Column(
                    children: <Widget>[
                        new UserAccountsDrawerHeader(
                            accountName: new Text(
                                this.acctName
                            ),
                            accountEmail: new Text(
                                this.acctEmail
                            ),
                            currentAccountPicture: new CircleAvatar(
                                backgroundColor: Colors.white,
                                child: new Icon(Icons.person),
                            ),
                        ),
                        new ListTile(
                            leading: new CircleAvatar(
                                child: new Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                    size: 20.0,
                                ),
                            ),
                            title: new Text(
                                'Order Notifications'
                            ),
                            onTap: () {
                                final pageRouteGirliesNotifications = new CupertinoPageRoute(
                                    builder: (context) => new GirliesNotifications()
                                );
                                Navigator.of(context).push(pageRouteGirliesNotifications);
                            },
                        ),
                        new ListTile(
                            leading: new CircleAvatar(
                                child: new Icon(
                                    Icons.history,
                                    color: Colors.white,
                                    size: 20.0,
                                ),
                            ),
                            title: new Text(
                                'Order History'
                            ),
                            onTap: () {
                                final pageRouteGirliesHistory = new CupertinoPageRoute(
                                    builder: (context) => new GirliesHistory()
                                );
                                Navigator.of(context).push(pageRouteGirliesHistory);
                            },
                        ),
                        new Divider(),
                        new ListTile(
                            leading: new CircleAvatar(
                                child: new Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 20.0,
                                ),
                            ),
                            title: new Text(
                                'Profile Settings'
                            ),
                            onTap: () {
                                final pageRouteGirliesProfile = new CupertinoPageRoute(
                                    builder: (context) => new GirliesProfile()
                                );
                                Navigator.of(context).push(pageRouteGirliesProfile);
                            },
                        ),
                        new ListTile(
                            leading: new CircleAvatar(
                                child: new Icon(
                                    Icons.home,
                                    color: Colors.white,
                                    size: 20.0,
                                ),
                            ),
                            title: new Text(
                                'Delivery Address'
                            ),
                            onTap: () {
                                final pageRouteGirliesDelivery = new CupertinoPageRoute(
                                    builder: (context) => new GirliesDelivery()
                                );
                                Navigator.of(context).push(pageRouteGirliesDelivery);
                            },
                        ),
                        new Divider(),
                        new ListTile(
                            trailing: new CircleAvatar(
                                child: new Icon(
                                    Icons.help,
                                    color: Colors.white,
                                    size: 20.0,
                                ),
                            ),
                            title: new Text(
                                'About Us'
                            ),
                            onTap: () {
                                final pageRouteGirliesAboutUs = new CupertinoPageRoute(
                                    builder: (context) => new GirliesAboutUs()
                                );
                                Navigator.of(context).push(pageRouteGirliesAboutUs);
                            },
                        ),
                        new ListTile(
                            trailing: new CircleAvatar(
                                child: new Icon(
                                    Icons.exit_to_app,
                                    color: Colors.white,
                                    size: 20.0,
                                ),
                            ),
                            title: new Text(
                                isLoggedIn == true ? 'Logout' : 'Login'
                            ),
                            onTap: checkIfLoggedIn,
                        ),
                    ],
                ),
            ),
            body: new StreamBuilder(
                stream: this.firestore.collection(appProducts).snapshots(),
                builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                        return new Center(
                            child: new CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor
                                )
                            ),
                        );
                    } else {
                        final int dataCount = snapshot.data.documents.length;
                        if (dataCount == 0) {
                            return noDataFound();
                        } else {
                            return new GridView.builder(
                                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.85
                                ),
                                itemCount: dataCount,
                                itemBuilder: (BuildContext buildContext, int index) {
                                    final DocumentSnapshot document = snapshot.data.documents[index];
                                    return buildProducts(buildContext, index, document);
                                }
                            );
                        }
                    }
                }
            )
        );
    }
}