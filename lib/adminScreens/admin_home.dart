import 'package:flutter/material.dart';
import 'package:shoppingapp/adminScreens/add_products.dart';
import 'package:shoppingapp/adminScreens/app_messages.dart';
import 'package:shoppingapp/adminScreens/app_orders.dart';
import 'package:shoppingapp/adminScreens/app_products.dart';
import 'package:shoppingapp/adminScreens/app_users.dart';
import 'package:shoppingapp/adminScreens/order_history.dart';
import 'package:shoppingapp/adminScreens/privilages.dart';
import 'package:shoppingapp/adminScreens/search_data.dart';

class AdminHome extends StatefulWidget {
    @override 
    State<StatefulWidget> createState() => new _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
    Size screenSize;

    @override
    Widget build(BuildContext buildContext) {
        screenSize = MediaQuery.of(context).size;
        return new Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: new AppBar(
                title: new Text('App Admin'),
                centerTitle: true,
                elevation: 0.0,
            ),
            endDrawer: new Container(
                width: screenSize.width - 50,
                color: Colors.white,
                child: new Column(
                    children: <Widget>[
                        new UserAccountsDrawerHeader(
                            accountName: new Text("PhongSn"), 
                            accountEmail: new Text("tranduyphong27121995@gmail.com"),
                            currentAccountPicture: new CircleAvatar(
                                backgroundColor: Colors.white,
                                child: new Icon(Icons.person)
                            ),
                        )
                    ],
                ),
            ),
            body: new SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: new Column(
                    children: <Widget>[
                        new SizedBox(
                            height: 20.0,
                        ),
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                                new GestureDetector(
                                    onTap: () {
                                        final pageRouteSearchData = new MaterialPageRoute(
                                            builder: (BuildContext buildContext) => new SearchData(),
                                        );
                                        Navigator.of(context).push(pageRouteSearchData);
                                    },
                                    child: new CircleAvatar(
                                        maxRadius: 70.0,
                                        child: new Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                new Icon(
                                                    Icons.search
                                                ),
                                                new SizedBox(
                                                    height: 10.0,
                                                ),
                                                new Text('Search Data')
                                            ]
                                        )
                                    ),
                                ),
                                new GestureDetector(
                                    onTap: () {
                                        final pageRouteAppUsers = new MaterialPageRoute(
                                            builder: (BuildContext buildContext) => new AppUsers()
                                        );
                                        Navigator.of(context).push(pageRouteAppUsers);
                                    },
                                    child: new CircleAvatar(
                                        maxRadius: 70.0,
                                        child: new Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                new Icon(
                                                    Icons.person
                                                ),
                                                new SizedBox(
                                                    height: 10.0,
                                                ),
                                                new Text('App Users')
                                            ]
                                        )
                                    ),
                                )
                            ]
                        ),
                        new SizedBox(
                            height: 20.0,
                        ),
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                                new GestureDetector(
                                    onTap: () {
                                        final pageRouteAppOrders = new MaterialPageRoute(
                                            builder: (BuildContext buildContext) => new AppOrders()
                                        );
                                        Navigator.of(context).push(pageRouteAppOrders);
                                    },
                                    child: new CircleAvatar(
                                        maxRadius: 70.0,
                                        child: new Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                new Icon(
                                                    Icons.notifications
                                                ),
                                                new SizedBox(
                                                    height: 10.0,
                                                ),
                                                new Text('App Orders')
                                            ]
                                        )
                                    ),
                                ),
                                new GestureDetector(
                                    onTap: () {
                                        final pageRouteAppMessages = new MaterialPageRoute(
                                            builder: (BuildContext buildContext) => new AppMessages()
                                        );
                                        Navigator.of(context).push(pageRouteAppMessages);
                                    },
                                    child: new CircleAvatar(
                                        maxRadius: 70.0,
                                        child: new Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                new Icon(
                                                    Icons.message
                                                ),
                                                new SizedBox(
                                                    height: 10.0,
                                                ),
                                                new Text('App Messages')
                                            ]
                                        )
                                    ),
                                )
                            ]
                        ),
                        new SizedBox(
                            height: 20.0,
                        ),
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                                new GestureDetector(
                                    onTap: () {
                                        final pageRouteAppProducts = new MaterialPageRoute(
                                        builder: (BuildContext buildContext) => new AppProducts()
                                        );
                                        Navigator.of(context).push(pageRouteAppProducts);
                                    },
                                    child: new CircleAvatar(
                                        maxRadius: 70.0,
                                        child: new Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                new Icon(
                                                    Icons.shop
                                                ),
                                                new SizedBox(
                                                    height: 10.0,
                                                ),
                                                new Text('App Products')
                                            ]
                                        )
                                    ),
                                ),
                                new GestureDetector(
                                    onTap: () {
                                        final pageRouteAddProducts = new MaterialPageRoute(
                                            builder: (BuildContext buildContext) => new AddProducts()
                                        );
                                        Navigator.of(context).push(pageRouteAddProducts);
                                    },
                                    child: new CircleAvatar(
                                        maxRadius: 70.0,
                                        child: new Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                new Icon(
                                                    Icons.add
                                                ),
                                                new SizedBox(
                                                    height: 10.0,
                                                ),
                                                new Text('Add Products')
                                            ]
                                        )
                                    ),
                                )
                            ]
                        ),
                        new SizedBox(
                            height: 20.0,
                        ),
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                                new GestureDetector(
                                    onTap: () {
                                        final pageRouteOrderHistory = new MaterialPageRoute(
                                            builder: (BuildContext buildContext) => new OrderHistory()
                                        );
                                        Navigator.of(context).push(pageRouteOrderHistory);
                                    },
                                    child: new CircleAvatar(
                                        maxRadius: 70.0,
                                        child: new Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                new Icon(
                                                    Icons.history
                                                ),
                                                new SizedBox(
                                                    height: 10.0,
                                                ),
                                                new Text('Order History')
                                            ]
                                        )
                                    ),
                                ),
                                new GestureDetector(
                                    onTap: () {
                                        final pageRoutePrivilages = new MaterialPageRoute(
                                            builder: (BuildContext buildContext) => new Privilages()
                                        );
                                        Navigator.of(context).push(pageRoutePrivilages);
                                    },
                                    child: new CircleAvatar(
                                        maxRadius: 70.0,
                                        child: new Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                                new Icon(
                                                    Icons.person
                                                ),
                                                new SizedBox(
                                                    height: 10.0,
                                                ),
                                                new Text('Privilages')
                                            ]
                                        )
                                    ),
                                )
                            ]
                        ),
                    ],
                ),
            )
        );
    }
}