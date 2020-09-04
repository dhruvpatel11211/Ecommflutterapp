import 'package:immaculateflutterecomm/models/product.dart';

class Customer {
  
  final String firstname;
  final String lastname;
  final String mobileno;
  final String email;
  final String uid;
  final List<Product> cart;
  final List<Product> savedForLater;
  final List<String> address;

  Customer({this.firstname, this.lastname, this.mobileno, this.email, this.uid, this.cart, this.address, this.savedForLater});

factory Customer.initialData() {
    return Customer(
      firstname: '',
      lastname: '',
      mobileno: '',
      email: '',
      uid: '',
      cart: [],
      savedForLater: [],
      address: []
    );
  }

}