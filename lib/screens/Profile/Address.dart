import 'package:immaculateflutterecomm/models/customer.dart';
import 'package:immaculateflutterecomm/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddressPage extends StatefulWidget {

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  // var address;
  var data;

  @override
  Widget build(BuildContext context) {
    Customer currentCustomer = Provider.of<Customer>(context);
    DatabaseService _databaseService =
        DatabaseService(uid: currentCustomer.uid);

    _addAddress(currentAddress) {
      final addressController = TextEditingController(text: currentAddress);
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
                _databaseService.addAddress(addressController.text);
                if (currentAddress != "") {
                  _databaseService.deleteAddress(currentAddress);
                  // setState(() {
                  //   address.removeWhere((add) => add == currentAddress);
                  // });
                }
                // setState(() {
                //   address.add(addressController.text);
                // });
                Navigator.pop(context);
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ]).show();
    }

    return Scaffold(
      appBar: AppBar(),
      body: currentCustomer.address.length == 0
          ? Container()
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
              itemCount: currentCustomer.address.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    padding: EdgeInsets.all(1),
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Center(
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(currentCustomer.address[index]
                                      .toString()))),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      _addAddress(currentCustomer.address[index]);
                                    }),
                                // SizedBox(width: 10,),
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      _databaseService.deleteAddress(
                                          currentCustomer.address[index]);
                                      Navigator.pop(context);
                                      // setState(() {
                                      //   currentCustomer.address.removeWhere(
                                      //       (add) => add == currentCustomer.address[index]);
                                      // });
                                    })
                              ],
                            ))
                      ],
                    ));
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addAddress("");
          },
          child: Icon(Icons.add)),
    );
  }
}
