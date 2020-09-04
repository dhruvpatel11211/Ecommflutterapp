
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:immaculateflutterecomm/models/drawer.dart';
class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}


final _firestore = Firestore.instance;

class _ProductDetailsState extends State<ProductDetails> {
  @override
  int aggregateRatings = 100;
  String name = '';
  int aggstar = 0;
  int userRating = 0;
  String desc = '';
  List variants = [];
  List<String> price = [];
  List<String> size = [];
  String dropdownValuesize = 'One';
  String dropdownValueprice = 'One';
  String dropdownValuediscount = 'One';
  List<String> discount = ['300 Rs'];
  String shopName = 'IITS';
  List<String> review = [];
  bool subscribe = false;
  void productsStream() async {
    await for (var snapshot in _firestore.collection('products').snapshots()) {
      for (var product in snapshot.documents) {
        setState(() {
          name = product.data['name'];
          aggstar = product.data['star'];
          desc = product.data['description'];
          variants = product.data['variants'];
          subscribe = product.data['subscribe'];
          print(product.data);
        });
        for (var varaint in variants) {
          price.add(varaint['price'] + ' Rs');
          size.add(varaint['size']);
        }
        setState(() {
          dropdownValuesize = size[0];
          dropdownValueprice = price[0];
          dropdownValuediscount = discount[0];
        });
        print(subscribe);
      }
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    productsStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Center(
          child: Title(
            color: Colors.blueAccent,
            child: Text('Ecommerce'),
          ),
        ),
      ),
      drawer: drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Colors.teal.shade500,
                        fontFamily: 'Acme',
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return IconTheme(
                        data: IconThemeData(
                          color: Colors.amber,
                          size: 20,
                        ),
                        child: Icon(
                          index < 2 ? Icons.star : Icons.star_border,
                        ),
                      );
                    }),
                  ),
                  Text(aggregateRatings.toString()),
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(child: Text(desc))),
              Padding(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                  width: 300,
                  height: 300.0,
                  child: new ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return new Image.network(
                          'https://images.squarespace-cdn.com/content/v1/59d2bea58a02c78793a95114/1589398875141-QL8O2W7QS3B4MZPFWHJV/ke17ZwdGBToddI8pDm48kBVDUY_ojHUJPbTAKvjNhBl7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QHyNOqBUUEtDDsRWrJLTmmV5_8-bAHr7cY_ioNsJS_wbCc47fY_dUiPbsewqOAk2CqqlDyATm2OxkJ1_5B47U/image-asset.jpeg');
                    },
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(child: Text('Sold By: $shopName'))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          style: BorderStyle.solid,
                          width: 0.80),
                    ),
                    child: DropdownButton<String>(
                      value: dropdownValuesize,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      iconEnabledColor: Colors.white,
                      elevation: 16,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValuesize = newValue;
                        });
                      },
                      items: size.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.monetization_on,
                    size: 30,
                    color: Colors.deepOrange,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        '$dropdownValueprice ',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '$dropdownValuediscount ',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 20,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ListTile(
                    leading: Icon(
                      Icons.shopping_cart,
                      size: 40,
                      color: Colors.pinkAccent,
                    ),
                    title: Center(
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ListTile(
                    leading: Icon(
                      Icons.arrow_drop_down_circle,
                      size: 40,
                      color: Colors.teal.shade500,
                    ),
                    title: Center(
                      child: Text(
                        'Buy Now/Rent Now',
                        style: TextStyle(
                          color: Colors.teal.shade500,
                          fontFamily: 'Acme',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              subscribe
                  ? FlatButton(
                      onPressed: () {},
                      child: Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: ListTile(
                          leading: Icon(
                            Icons.redeem,
                            size: 40,
                            color: Colors.orange.shade500,
                          ),
                          title: Center(
                            child: Text(
                              'Subscribe',
                              style: TextStyle(
                                color: Colors.orange.shade500,
                                fontFamily: 'Acme',
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Text('Subscribtion not available'),
              FlatButton(
                onPressed: () {},
                child: Card(
                  margin:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ListTile(
                    leading: Icon(
                      Icons.favorite,
                      size: 40,
                      color: Colors.redAccent,
                    ),
                    title: Center(
                      child: Text(
                        'Add to WishList',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontFamily: 'Acme',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Reviews',
                          style: TextStyle(color: Colors.blue[800]),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('rev'),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return IconTheme(
                    data: IconThemeData(
                      color: Colors.amber,
                      size: 20,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          userRating = index;
                        });
                      },
                      icon: Icon(
                        index < userRating + 1 ? Icons.star : Icons.star_border,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


