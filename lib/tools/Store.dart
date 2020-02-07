class Store {
    String itemName;
    String itemPrice;
    String itemImage;
    String itemRating;

    Store.items({
        this.itemName,
        this.itemPrice,
        this.itemImage,
        this.itemRating
    });
}

List<Store> stores = [
    new Store.items(itemName: 'Product 1', itemPrice: '1000.00', itemImage: 'https://cdn.vuahanghieu.com/unsafe/0x900/left/top/smart/filters:quality(90)/https://admin.vuahanghieu.com/upload/product/2019/08/mlb-la-dodgers-sneaker-big-ball-chunky-a-5d68edd37b177-30082019163515.jpg', itemRating: '3.0'),
    new Store.items(itemName: 'Product 2', itemPrice: '1500.00', itemImage: 'https://media3.scdn.vn/img3/2019/3_15/gamszq_simg_de2fe0_500x500_maxb.jpg', itemRating: '4.0'),
    new Store.items(itemName: 'Product 3', itemPrice: '1200.00', itemImage: 'https://cdn02.static-adayroi.com/0/2019/04/12/1555040868616_9286640.jpg', itemRating: '3.5'),
    new Store.items(itemName: 'Product 4', itemPrice: '1200.00', itemImage: 'http://sc01.alicdn.com/kf/HTB1mbkRJVXXXXXsXpXXq6xXFXXXB.jpg', itemRating: '3.0'),
    new Store.items(itemName: 'Product 5', itemPrice: '1700.00', itemImage: 'https://www.fashionmela.net/wp-content/uploads/2016/06/ElaCentelha-Brand-Dress-Summer-Women-High-Quality-Embroidery-Print-Dress-Casual-Sleeveless-Slim-Waist-Womens-OL-Office-Dresses-1.jpg', itemRating: '5.0'),
    new Store.items(itemName: 'Product 6', itemPrice: '2000.00', itemImage: 'http://www.cstylejeans.com/wp-content/uploads/2016/01/womens-fashion-clothes-kookai-australia.jpg', itemRating: '4.5'),
    new Store.items(itemName: 'Product 7', itemPrice: '2500.00', itemImage: 'http://alomypham.net/wp-content/uploads/son_mau_s-white_pink.png', itemRating: '5.0')
];