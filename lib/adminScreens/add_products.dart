import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shoppingapp/tools/app_data.dart' as appData;
import 'package:shoppingapp/tools/app_methods.dart';
import 'package:shoppingapp/tools/app_tools.dart';
import 'package:shoppingapp/tools/firebase_methods.dart';

class AddProducts extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => new _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
    List<DropdownMenuItem<String>> colors;
    String selectedColor;
    List<String> colorList = new List();

    List<DropdownMenuItem<String>> sizes;
    String selectedSize;
    List<String> sizeList = new List();

    List<DropdownMenuItem<String>> categories;
    String selectedCategory;
    List<String> categoryList = new List();

    List<File> images;
    TextEditingController txtProductTitle;
    TextEditingController txtProductPrice;
    TextEditingController txtProuctDescription;

    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

    AppMethods appMethod = new FirebaseMethods();

    BuildContext buildContext;

    @override
    void initState() {
        super.initState();
        this.txtProductTitle = new TextEditingController();
        this.txtProductPrice = new TextEditingController();
        this.txtProuctDescription = new TextEditingController();

        this.colorList = new List.from(appData.colors);
        this.colors = this.buildAndGetDropDownItems(this.colorList);
        this.selectedColor = this.colors[0].value;

        this.sizeList = new List.from(appData.sizes);
        this.sizes = this.buildAndGetDropDownItems(this.sizeList);
        this.selectedSize = this.sizes[0].value;

        this.categoryList = new List.from(appData.categories);
        this.categories = this.buildAndGetDropDownItems(this.categoryList);
        this.selectedCategory = this.categories[0].value;
    }

    addNewProduct() async {
        if (this.images == null || this.images.length == 0) {
            showSnackBar('Product Images cannot be empty', scaffoldKey);
            return;
        }
        if (this.txtProductTitle.text == '') {
            showSnackBar('Product Title cannot be emty', scaffoldKey);
            return;
        }
        if (this.txtProductPrice.text == '') {
            showSnackBar('Product Price cannot be emty', scaffoldKey);
            return;
        }
        if (this.txtProuctDescription.text == '') {
            showSnackBar('Product Description cannot be emty', scaffoldKey);
            return;
        }
        if (this.selectedCategory == 'Select Product category') {
            showSnackBar('Please select a category', scaffoldKey);
            return;
        }
        if (this.selectedColor == 'Select a color') {
            showSnackBar('Please select a color', scaffoldKey);
            return;
        }
        if (this.selectedSize == 'Select a size') {
            showSnackBar('Please select a size', scaffoldKey);
            return;
        }

        displayProgressDialog(this.buildContext);

        Map<String, dynamic> map = new Map<String, dynamic>();

        map[appData.productTitle] = this.txtProductTitle.text;
        map[appData.productPrice] = this.txtProductPrice.text;
        map[appData.productDescription] = this.txtProuctDescription.text;
        map[appData.productCategory] = this.selectedCategory;
        map[appData.productColor] = this.selectedColor;
        map[appData.productSize] = this.selectedSize;

        String productID = await appMethod.addNewProduct(newProduct: map);

        List<String> imageUrls = await appMethod.uploadProductImages(iOsImages: this.images, docID: productID);

        if (imageUrls.contains(appData.error)) {
            closeProgressDialog(this.buildContext);
            showSnackBar('Image Upload Error, Contact developer', scaffoldKey);
            return;
        }

        bool result = await appMethod.updateProductImages(docID: productID, data: imageUrls);

        if (result != null && result == true) {
            this.resetEverything();
            closeProgressDialog(this.buildContext);
            showSnackBar('Product added successfully', scaffoldKey);
        } else {
            closeProgressDialog(this.buildContext);
            showSnackBar('An Error Occurred Contact developer', scaffoldKey);
        }


    }

    void resetEverything() {
        this.txtProductTitle.text = '';
        this.txtProductPrice.text = '';
        this.txtProuctDescription.text = '';
        this.selectedCategory = 'Select product category';
        this.selectedColor = 'Select a color';
        this.selectedSize = 'Select a size';
        this.setState(() {});
    }

    onChangeColor(value) {
        this.setState(() {
            this.selectedColor = value;
        });
    }

    onChangeSize(value) {
        this.setState(() {
            this.selectedSize = value;
        });
    }

    onChangeCategory(value) {
        this.setState(() {
            this.selectedCategory = value;
        });
    }

    List<DropdownMenuItem<String>> buildAndGetDropDownItems(List<String> list) {
        List<DropdownMenuItem<String>> items = new List();
        for (String item in list) {
            items.add(new DropdownMenuItem(
                child: new Text(item),
                value: item,
            ));
        }
        return items;
    }

    pickImage() async {
        File image = await ImagePicker.pickImage(
            source: ImageSource.gallery
        );

        if (image != null) {
            List<File> list = new List();

            list.add(image);

            if (this.images == null) {
                this.images = new List.from(list, growable: true);
            } else {
                for (int i = 0; i < list.length; i++) {
                    this.images.add(image);
                }
            }

            this.setState(() { });
        }
    }

    removeImage(int index) async {
        this.images.removeAt(index);
        this.setState(() { });
    }

    @override
    Widget build(BuildContext buildContext) {
        this.buildContext = buildContext;
        return new Scaffold(
            key: this.scaffoldKey,
            backgroundColor: Theme.of(context).primaryColor,
            appBar: new AppBar(
                title: new Text('App Products'),
                centerTitle: false,
                elevation: 0.0,
                actions: <Widget>[
                    new Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new RaisedButton.icon(
                            color: Colors.green,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(15.0)
                                )
                            ),
                            onPressed: this.pickImage,
                            icon: new Icon(
                                Icons.add,
                                color: Colors.white
                            ),
                            label: new Text(
                                'Add Images',
                                style: new TextStyle(
                                    color: Colors.white
                                ),
                            )
                        ),
                    )
                ],
            ),
            body: new SingleChildScrollView(
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        new SizedBox(
                            height: 10.0,
                        ),
                        multiImagePickerList(
                            images: this.images,
                            remove: (index) {
                                removeImage(index);
                            }
                        ),
                        new SizedBox(
                            height: 10.0,
                        ),
                        productTextFiled(
                            titleText: 'Product Title',
                            textHint: 'Enter Product Title',
                            controller: this.txtProductTitle
                        ),
                        new SizedBox(
                            height: 10.0,
                        ),
                        productTextFiled(
                            titleText: 'Product Price',
                            textHint: 'Enter Product Price',
                            textType: TextInputType.number,
                            controller: this.txtProductPrice
                        ),
                        new SizedBox(
                            height: 10.0,
                        ),
                        productTextFiled(
                            titleText: 'Product Description',
                            textHint: 'Enter Product Description',
                            height: 180,
                            controller: this.txtProuctDescription,
                            maxLines: 4
                        ),
                        new SizedBox(
                            height: 10.0,
                        ),
                        productDropDown(
                            titleText: 'Product Category',
                            items: this.categories,
                            selected: this.selectedCategory,
                            onChange: onChangeCategory
                        ),
                        new SizedBox(
                            height: 10.0,
                        ),
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                productDropDown(
                                    titleText: 'Product Color',
                                    items: this.colors,
                                    selected: this.selectedColor,
                                    onChange: onChangeColor
                                ),
                                productDropDown(
                                    titleText: 'Product Size',
                                    items: this.sizes,
                                    selected: this.selectedSize,
                                    onChange: onChangeSize
                                )
                            ],
                        ),
                        new SizedBox(
                            height: 20.0,
                        ),
                        appButton(
                            btnTxt: 'Add Product',
                            onBtnClicked: addNewProduct,
                            btnPadding: 20.0,
                            btnColor: Theme.of(context).primaryColor
                        )
                    ],
                ),
            )
        );
    }
}