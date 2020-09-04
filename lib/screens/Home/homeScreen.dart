import 'package:immaculateflutterecomm/components/HomeProducts.dart';
import 'package:immaculateflutterecomm/models/customer.dart';
import 'package:immaculateflutterecomm/models/user.dart';
import 'package:immaculateflutterecomm/screens/Cart/WishListScreen.dart';
import 'package:immaculateflutterecomm/screens/Home/search.dart';
import 'package:immaculateflutterecomm/screens/Profile/Address.dart';
import 'package:immaculateflutterecomm/screens/Cart/cart.dart';
import 'package:immaculateflutterecomm/screens/Profile/editProfile.dart';
import 'package:immaculateflutterecomm/services/auth.dart';
import 'package:immaculateflutterecomm/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
String currentAddress='Choose address';
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabcontroller;
  String firstName = "Dhruv";
  String email = "dhruvpatel11611@gmail.com";
  var shopList = [];
  var rentList = [];
  var refurbishedList = [];
  bool isLoaded = false;

  void initState() {
    super.initState();
    this._tabcontroller = TabController(length: 3, vsync: this);
    this._tabcontroller.addListener(handleTab);
  }

  @override
  void dispose() {
    _tabcontroller.dispose();
    super.dispose();
  }

  handleTab() {
    if (_tabcontroller.indexIsChanging) setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final AuthService _authService = AuthService();
    Customer currentCustomer = Provider.of<Customer>(context);
    print("Current Customer");
    print(currentCustomer.cart);
    DatabaseService _databaseService = DatabaseService(uid: currentCustomer.uid);
    List<String> address=currentCustomer.address;
    print(address);
    String firstName=currentCustomer.firstname;
    if(!isLoaded){
      var localShopList = _databaseService.getCategoryProducts("shop");
      localShopList.then((list) => setState((){
          shopList = list;
      }));
      var localRentList = _databaseService.getCategoryProducts("rent");
      localRentList.then((list) => setState((){
          rentList = list;
      }));
      var localRefurbishedList = _databaseService.getCategoryProducts("refurbished");
      localRefurbishedList.then((list) => setState((){
        refurbishedList = list;
      }));
      isLoaded = true;
    }
    _addAddress(currentAddress1) {
      final addressController = TextEditingController(text: currentAddress1);
      Alert(
          context: context,
          title: "Add Address",
          content: Column(
            children: <Widget>[
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  icon: Icon(Icons.home),
                  labelText: 'Address',
                ),
              ),
            ],
          ),
          buttons: [
            DialogButton(
              onPressed: () {
                setState(() {
                  currentAddress=currentAddress1;
                  print(currentAddress);
                });
                _databaseService.addAddress(addressController.text);
                // setState(() {
                //   address.add(addressController.text);
                // });
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ]).show();
    }
    Widget imageCarousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS9JvP3qRiJ4GY_xEwaCEMF4a28Odn1sIwKlw&usqp=CAU'),
          NetworkImage(
              'https://www.thegrocers.com/wp-content/uploads/2018/08/Sunsilk-Perfect-Straight-Shampo-200ml-1.jpg'),
          NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQjaq7RVf9Q6zVwnJWv4F3T9OdUVBM4NZGfWw&usqp=CAU'),
        ],
        autoplay: false,
//      animationCurve: Curves.fastOutSlowIn,
//      animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
      ),
    );

    List<Widget> tabsInfo = [
      Container(
        height: 40,
        padding: EdgeInsets.only(top:10),
        child: Container(child: Text("Shop")),
      ),
      Container(
        height: 40,
        padding: EdgeInsets.only(top:10),
        child: Text("Rent"),
      ),
      Container(
        height: 40,
        padding: EdgeInsets.only(top:10),
        child: Text("Refurbished"),
      )
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.1,
            backgroundColor: Colors.blueAccent,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {   
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Cart()));
                  })
            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('Hello, $firstName'),
                  accountEmail: Text(email),
                  currentAccountPicture: null,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProfile()));
                  },
                  child: ListTile(
                    title: Text('Edit Profile'),
                    leading: Icon(Icons.person),
                  ),
                ),
                InkWell(
                  onTap: () {

                  },
                  child: ListTile(
                    title: Text('Home'),
                    leading: Icon(Icons.home),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text('Shop by Category'),
                    leading: Icon(Icons.category),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WishList()));
                  },
                  child: ListTile(
                    title: Text('My WishList'),
                    leading: Icon(Icons.favorite),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text('My Orders'),
                    leading: Icon(Icons.store),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text('My Subscriptions'),
                    leading: Icon(Icons.redeem),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text('Your Notifications'),
                    leading: Icon(Icons.notifications_active),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text('Settings'),
                    leading: Icon(Icons.settings),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text('About Us'),
                    leading: Icon(Icons.help_outline),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text('Help and Support'),
                    leading: Icon(Icons.supervisor_account),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _authService.signOut();
                  },
                  child: ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.remove),
                  ),
                ),
              ],
            ),
          ),
          body: ListView(
            children: <Widget>[
              SizedBox(
                height: 30,
                width: double.infinity,
                child: InkWell(
                  onTap: (){
                    currentAddress=address[0];
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context){
                          return Container(
                            height: 280,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Choose your Location',style: TextStyle(fontSize: 15),),
                                ),
                                Text('Select a delievery location',style: TextStyle(fontSize: 10),),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 20.0),
                                  height: 130.0,
                                  child: ListView.builder(
                                    itemCount: address.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context,index)
                                    {
                                      return InkWell(
                                        onTap: (){
                                          print(address[index]);
                                          setState(() {
                                            currentAddress=address[index];
                                          });
                                        },
                                        child: Container(
                                          width: 130.0,
                                          child: Card(
                                            elevation: 10,
                                            child: Center(child: Text(address[index])),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _addAddress(currentAddress);
                                  },
                                  child: ListTile(
                                    title: Text('Add Address'),
                                    leading: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                    );

                   },
                  child: ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Deliver to $firstName - $currentAddress'),
                    trailing: Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
              SizedBox(height: 20,width: double.infinity,),
              imageCarousel,
              TabBar(
                controller: _tabcontroller,
                labelColor: Colors.redAccent,
                tabs: tabsInfo,
                indicatorColor: Colors.redAccent,
                unselectedLabelColor: Colors.black,
              ),
              Center(
                  child: [
                HomeProducts(productList: shopList),
                HomeProducts(productList: rentList),
                HomeProducts(productList: refurbishedList),
              ][_tabcontroller.index]),
              // Padding(
              //     padding: EdgeInsets.all(20), child: Text("Recent Products")),
            ],
          )
          ),
    );
  }
}

