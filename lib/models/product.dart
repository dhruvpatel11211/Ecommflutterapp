class Product {
  final String id;
  final String name;
  final String picture;
  final int qty;
  final int price;

  Product({this.id, this.name, this.picture, this.qty, this.price});

  factory Product.fromMap(item) {
    return Product(
      id: item['id'],
      name: item['name'],
      picture: item['picture'],
      qty: item['qty'],
      price: item['price']
    );
  }

}