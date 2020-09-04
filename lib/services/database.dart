import 'package:immaculateflutterecomm/models/customer.dart';
import 'package:immaculateflutterecomm/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  // DatabaseService({this.uid});

  DatabaseService({this.uid});

  final CollectionReference customersCollection =
      Firestore.instance.collection("Customers");

  final CollectionReference productCollection =
      Firestore.instance.collection("products");

  Future putUserData(
      String email, String firstname, String lastname, String mobileno) async {
    print("USER ID IS: ");
    print(uid);

    return await customersCollection.document(uid).setData({
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'mobileno': mobileno
    }, merge: true);
  }

  Future updateUserDetails(firstname, lastname, email, mobileno) async {
    customersCollection.document(uid).updateData({
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'mobileno': mobileno
    });
  }

  Future<Object> getProductData() async {
    return customersCollection.document(uid).get().then((val) {
      return val.data;
    });
  }

  Future updateCounter(qty, pid) async {
    customersCollection.document(uid).updateData({
      "cart": FieldValue.arrayUnion([
        {'id': pid, 'qty': qty}
      ])
    });
  }

  Future deleteFromCart(id, name, picture, price, qty) async {
    return customersCollection.document(uid).updateData({
      "cart": FieldValue.arrayRemove([
        {'id': id, 'name': name, 'picture': picture, 'price': price, 'qty': qty}
      ])
    });
  }

  Future deleteAddress(address) async {
    return customersCollection.document(uid).updateData({
      "Address": FieldValue.arrayRemove([address])
    });
  }

  Future deleteFromSaved(id, name, img, price, qty) async {
    return customersCollection.document(uid).updateData({
      "savedForLater": FieldValue.arrayRemove([
        {'id': id, 'name': name, 'picture': img, 'price': price, 'qty': qty}
      ])
    });
  }

  addProductField(id, name, img, price, qty) async {
    customersCollection.document(uid).updateData({
      "cart": FieldValue.arrayUnion([
        {'id': id, 'name': name, 'picture': img, 'price': price, 'qty': qty}
      ])
    });

    customersCollection.document(uid).updateData({
      "savedForLater": FieldValue.arrayRemove([
        {'id': id, 'name': name, 'picture': img, 'price': price, 'qty': qty}
      ])
    });
  }

  Future addAddress(address) async {
    customersCollection.document(uid).updateData({
      "Address": FieldValue.arrayUnion([address])
    });
  }

  Future addLaterField(id, name, picture, price, qty) async {
    customersCollection.document(uid).updateData({
      "savedForLater": FieldValue.arrayUnion([
        {'id': id, 'name': name, 'picture': picture, 'price': price, 'qty': qty}
      ])
    });

    return customersCollection.document(uid).updateData({
      "cart": FieldValue.arrayRemove([
        {'id': id, 'name': name, 'picture': picture, 'price': price, 'qty': qty}
      ])
    });
  }

  Future getCategoryProducts(String category) async {
    return productCollection
        .where("category", isEqualTo: category)
        .getDocuments()
        .then((querySnapshot) {
      return querySnapshot.documents.map((result) {
        return (result.data);
      }).toList();
    });
  }

  Customer _customerFromSnapshot(DocumentSnapshot snapshot) {
    return Customer(
        email: snapshot.data['email'] ?? '',
        firstname: snapshot.data['firstname'] ?? '',
        lastname: snapshot.data['lastname'] ?? '',
        mobileno: snapshot.data['mobileno'] ?? '',
        uid: uid,
        cart: snapshot.data['cart'] != null ? snapshot.data['cart']
                .map<Product>((item) => Product.fromMap(item)).toList() : [],
        address: snapshot.data['Address'] != null ? snapshot.data['Address']
                .map<String>((item) => item.toString())
                .toList() :[],
        savedForLater: snapshot.data['savedForLater'] != null ? snapshot.data['savedForLater']
                .map<Product>((item) => Product.fromMap(item))
                .toList() : []
                );
  }

  Stream<Customer> get customer {
    return customersCollection
        .document(uid)
        .snapshots()
        .map(_customerFromSnapshot);
  }
}
