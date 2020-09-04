import 'package:immaculateflutterecomm/models/customer.dart';
import 'package:immaculateflutterecomm/models/product.dart';
import 'package:immaculateflutterecomm/screens/Cart/savedforlater.dart';
import 'package:immaculateflutterecomm/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    Customer customer = Provider.of<Customer>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text("Total Cart Items"),
                subtitle: Text(customer.cart.length.toString()),
              ),
            ),
            Expanded(
                child: MaterialButton(
              onPressed: () {},
              child: Text(
                "Check out",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.redAccent,
            ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CartProducts(customer: customer),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Saved For later",
                style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
              ),
            ),
            SavedProducts()
          ],
        ),
      ),
    );
  }
}

class CartProducts extends StatefulWidget {
  final Customer customer;

  const CartProducts({Key key, this.customer}) : super(key: key);
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  @override
  Widget build(BuildContext context) {
    Customer currentCustomer = widget.customer;
    List<dynamic> cart = currentCustomer.cart;

    print("CART");
    print(cart);

    if (cart.length != 0)
      return Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: cart.length,
            itemBuilder: (context, index) {
              return SingleCartProduct(
                uid: currentCustomer.uid,
                id: cart[index].id,
                name: cart[index].name,
                price: cart[index].price,
                qty: cart[index].qty,
                picture: cart[index].picture,
              );
            }),
      );
    return Container();
  }
}

class SingleCartProduct extends StatefulWidget {
  final name;
  final price;
  final qty;
  final picture;
  final id;
  final uid;
  SingleCartProduct(
      {this.id, this.name, this.price, this.qty, this.picture, this.uid});

  @override
  _SingleCartProductState createState() => _SingleCartProductState();
}

class _SingleCartProductState extends State<SingleCartProduct> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    DatabaseService _databaseService = DatabaseService(uid: widget.uid);

    void incrementCounter() {
      print(counter);
      setState(() {
        counter++;
      });
    }

    void decrementCounter() {
      setState(() {
        if (counter == 0) {
          return;
        }
        counter--;
      });
    }

    return Card(
      elevation: 11,
      margin: EdgeInsets.all(10),
      child: Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(15),
                  ),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(widget.picture))),
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: 100,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.name),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                        child: Container(
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.teal),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            widget.price.toString() + " Rs",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        child: OutlineButton(
                            child: new Text(
                              "Save for later",
                              style: TextStyle(fontSize: 10),
                            ),
                            onPressed: () {
                              var result = _databaseService.addLaterField(
                                  widget.id,
                                  widget.name,
                                  widget.picture,
                                  widget.price,
                                  widget.qty);
                              result.catchError((onError) {
                                print(onError);
                              });
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0))),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                      child: FlatButton(
                          onPressed: () {
                            var result = _databaseService.deleteFromCart(
                                widget.id,
                                widget.name,
                                widget.picture,
                                widget.price,
                                widget.qty);
                            result.catchError((onError) {
                              print(onError);
                            });
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: GestureDetector(
                            onTap: decrementCounter,
                            child: Icon(
                              Icons.arrow_left,
                              size: 30,
                            )),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 6, right: 6),
                          child: Text(
                            '$counter',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: GestureDetector(
                            onTap: incrementCounter,
                            child: Icon(
                              Icons.arrow_right,
                              size: 30,
                            )),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
