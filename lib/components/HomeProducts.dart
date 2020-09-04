import 'package:immaculateflutterecomm/screens/Cart/ProductDetailsScreen.dart';
import 'package:flutter/material.dart';

class HomeProducts extends StatefulWidget {
  final productList;
  HomeProducts({this.productList});
  @override
  _HomeProductsState createState() => _HomeProductsState();
}

class _HomeProductsState extends State<HomeProducts> {
  // var product_list = [
  //   {
  //     "name": "Blazer",
  //     "picture": '',
  //     "old_price": 120,
  //     "price": 85,
  //   },
  //   {
  //     "name": "Red dress",
  //     "picture": '',
  //     "old_price": 100,
  //     "price": 50,
  //   }
  // ];

  @override
  Widget build(BuildContext context) {
    final product_list = widget.productList;
    return GridView.builder(
        itemCount: product_list.length,
        shrinkWrap: true,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Single_prod(
            prod_name: product_list[index]['name'],
            prod_picture: product_list[index]['picture'],
            prod_old_price: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
          );
        });
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Single_prod({
    this.prod_name,
    this.prod_picture,
    this.prod_old_price,
    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(
              onTap: () {},
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                        leading: Text(
                          prod_name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        title: Text(
                          "\Rs $prod_price",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          "\Rs $prod_old_price",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w800,
                              decoration
                                  :TextDecoration.lineThrough),
                        ),
                    ),
                  ),
                  child: Image.network(prod_picture)
                  ),
            ),
          )),
    );
  }
}