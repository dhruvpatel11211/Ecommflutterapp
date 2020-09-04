import 'package:immaculateflutterecomm/models/customer.dart';
import 'package:immaculateflutterecomm/models/product.dart';
import 'package:immaculateflutterecomm/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedProducts extends StatefulWidget {
  @override
  _SavedProductsState createState() => _SavedProductsState();
}

class _SavedProductsState extends State<SavedProducts> {
  // var results;
  // var savedForLater;

  // var savedForLater = [
  //   {
  //     "name": "ABC",
  //     "picture":
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQjaq7RVf9Q6zVwnJWv4F3T9OdUVBM4NZGfWw&usqp=CAU",
  //     "price": 50,
  //     "size": "M",
  //     "color": "Red"
  //   },
  //   {
  //     "name": "pqr",
  //     "picture":
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQjaq7RVf9Q6zVwnJWv4F3T9OdUVBM4NZGfWw&usqp=CAU",
  //     "price": 50,
  //     "size": "7",
  //     "qty": 1,
  //     "color": "Red"
  //   }
  // ];

  @override
  Widget build(BuildContext context) {
    Customer currentCustomer = Provider.of<Customer>(context);
    List<dynamic> savedForLater = currentCustomer.savedForLater;

    if (savedForLater != null)
      return Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: savedForLater.length,
            itemBuilder: (context, index) {
              return SingleSavedProduct(
                uid: currentCustomer.uid,
                id: savedForLater[index].id,
                name: savedForLater[index].name,
                price: savedForLater[index].price,
                qty: savedForLater[index].qty,
                picture: savedForLater[index].picture,
              );
            }),
      );
    return Container();
  }
}

class SingleSavedProduct extends StatefulWidget {
  final name;
  final price;
  final qty;
  final picture;
  final id;
  final uid;
  SingleSavedProduct(
      {this.id, this.name, this.price, this.qty, this.picture, this.uid});

  @override
  _SingleSavedProductState createState() => _SingleSavedProductState();
}

class _SingleSavedProductState extends State<SingleSavedProduct> {
  @override
  Widget build(BuildContext context) {
    DatabaseService _databaseService = DatabaseService(uid: widget.uid);
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
                              "add to cart",
                              style: TextStyle(fontSize: 10),
                            ),
                            onPressed: () {
                              var result = _databaseService.addProductField(
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
                height: 100,
                child: FlatButton(
                    onPressed: () {
                      var result = _databaseService.deleteFromSaved(
                          widget.id,
                          widget.name,
                          widget.picture,
                          widget.price,
                          widget.qty);
                      // Delete from savedForLater
                      result.catchError((onError) {
                        print(onError);
                      });
                      result.then((value) => {});
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    )))
          ],
        ),
      ),
    );
  }
}

// class SavedForLater extends StatefulWidget {
//   @override
//   _SavedForLaterState createState() => _SavedForLaterState();
// }

// class _SavedForLaterState extends State<SavedForLater> {
//   @override
//   Widget build(BuildContext context) {
//     return SavedForLater();
//   }
// }

// class SavedProducts extends StatefulWidget {
//   @override
//   _SavedProductsState createState() => _SavedProductsState();
// }

// class _SavedProductsState extends State<SavedProducts> {
//   var Product_on_cart = [
//     {
//       "name": "ABC",
//       "picture":
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQjaq7RVf9Q6zVwnJWv4F3T9OdUVBM4NZGfWw&usqp=CAU",
//       "price": 50,
//       "size": "M",
//       "color": "Red"
//     },
//     {
//       "name": "pqr",
//       "picture":
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQjaq7RVf9Q6zVwnJWv4F3T9OdUVBM4NZGfWw&usqp=CAU",
//       "price": 50,
//       "size": "7",
//       "qty": 1,
//       "color": "Red"
//     }
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: Product_on_cart.length,
//         itemBuilder: (context, index) {
//           return SingleSaved(
//             prod_name: Product_on_cart[index]["name"],
//             prod_price: Product_on_cart[index]["price"],
//             prod_qty: Product_on_cart[index]["qty"],
//             prod_photo: Product_on_cart[index]["picture"],
//           );
//         });
//   }
// }
// class SingleSaved extends StatefulWidget {
//   final prod_name;
//   final prod_price;
//   final prod_qty;
//   final prod_photo;

//   SingleSaved(
//       {this.prod_name, this.prod_price, this.prod_qty, this.prod_photo});

//   @override
//   _SingleSavedState createState() => _SingleSavedState();
// }

// class _SingleSavedState extends State<SingleSaved> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       child: Container(
//         height: 100,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               height: 100,
//               width: 100,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(10),
//                     topLeft: Radius.circular(15),
//                   ),
//                   image: DecorationImage(
//                       fit: BoxFit.cover, image: NetworkImage(widget.prod_photo))),
//             ),
//             Flexible(
//               flex: 1,
//               child: Container(
//                 height: 100,
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(widget.prod_name),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
//                         child: Container(
//                           width: 70,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.teal),
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                           ),
//                           child: Text(
//                             widget.prod_price.toString() + " Rs",
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         child: OutlineButton(
//                             child: new Text("Save for later"),
//                             onPressed: null,
//                             shape: new RoundedRectangleBorder(
//                                 borderRadius: new BorderRadius.circular(30.0))),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             // Container(
//             //     height: 100,
//             //     child: FlatButton(
//             //         onPressed: () {}, child: Icon(Icons.delete)))
//           ],
//         ),
//       ),
//     );
//   }
// }
