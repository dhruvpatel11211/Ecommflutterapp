import 'dart:io';

import 'package:immaculateflutterecomm/models/customer.dart';
import 'package:immaculateflutterecomm/screens/Profile/Address.dart';
import 'package:immaculateflutterecomm/screens/Authenticate/changePassword.dart';
import 'package:immaculateflutterecomm/screens/Authenticate/resetPassword.dart';
import 'package:immaculateflutterecomm/services/auth.dart';
import 'package:immaculateflutterecomm/services/database.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File _image;
  String _uploadedFileURL;
  final _formKey = GlobalKey<FormState>();
  var results;
  
  final emailController = TextEditingController(text: "");
  final firstNameController = TextEditingController(text: "");
  final lastNameController = TextEditingController(text: "");
  final mobilenoController = TextEditingController(text: "");

  String error = "";

  final border = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 0),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  Future chooseFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera,imageQuality: 80);
    setState(() {
      _image = File(pickedFile.path);
    });
  }
  
  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    Customer currentCustomer = Provider.of<Customer>(context);
    DatabaseService _databaseService = DatabaseService(uid: currentCustomer.uid);
    emailController.text = currentCustomer.email;
    firstNameController.text = currentCustomer.firstname;
    lastNameController.text = currentCustomer.lastname;
    mobilenoController.text =currentCustomer.mobileno;

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(30),
                child: Form(
                    key: _formKey,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text(
                            "Edit Profile",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Edit your details",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Column(
                              children: <Widget>[
                                _image != null
                                    ? CircleAvatar(
                                  child: Image.asset(
                                    _image.path,
                                    height: 150,
                                  ),
                                )
                                    : CircleAvatar(
                                  backgroundImage: AssetImage('assets/googleSignIn.png'),
                                  radius: 100,
                                ),
                                _image == null
                                    ? RaisedButton(
                                  child: Text('Choose File'),
                                  onPressed: chooseFile,
                                  color: Colors.cyan,
                                )
                                    : Container(),
                                _image != null
                                    ? RaisedButton(
                                  child: Text('Upload File'),
                                  onPressed: uploadFile,
                                  color: Colors.cyan,
                                )
                                    : Container(),
                                _image != null
                                    ? RaisedButton(
                                    child: Text('Clear Selection'),
                                    onPressed: (){_image==null;}
                                )
                                    : Container(),
                                _uploadedFileURL != null
                                    ? Text('Uploaded image:')
                                    : Container(),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 40,
                            child: TextFormField(
                              controller: firstNameController,
                              decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.all(5),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    size: 20,
                                  ),
                                  hintText: "First Name",
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                  ),
                                  filled: true,
                                  fillColor: Colors.black12,
                                  enabledBorder: border,
                                  focusedBorder: border),
                              validator: (val) =>
                                  val.isEmpty ? "First Name is empty" : null,
                              
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 40,
                            child: TextFormField(
                              controller: lastNameController,
                              decoration: InputDecoration(
                                contentPadding: new EdgeInsets.all(5),
                                prefixIcon: Icon(
                                  Icons.person,
                                  size: 20,
                                ),
                                hintText: "Last Name",
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                ),
                                filled: true,
                                fillColor: Colors.black12,
                                enabledBorder: border,
                                focusedBorder: border,
                                border: InputBorder.none,
                              ),
                              validator: (val) =>
                                  val.isEmpty ? "Last name is empty" : null,
                             
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 40,
                            child: TextFormField(
                              controller: mobilenoController,
                              decoration: InputDecoration(
                                contentPadding: new EdgeInsets.all(5),
                                prefixIcon: Icon(Icons.phone, size: 20),
                                hintText: "Mobile Number",
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                ),
                                filled: true,
                                fillColor: Colors.black12,
                                enabledBorder: border,
                                focusedBorder: border,
                                border: InputBorder.none,
                              ),
                              validator: (val) =>
                                  val.length != 10 ? "Must be 10 digits" : null,
                              
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 40,
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  contentPadding: new EdgeInsets.all(5),
                                  prefixIcon: Icon(Icons.email, size: 20),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                  ),
                                  filled: true,
                                  fillColor: Colors.black12,
                                  enabledBorder: border,
                                  focusedBorder: border,
                                  border: InputBorder.none),
                              validator: (val) =>
                                  val.isEmpty ? "Email is empty" : null,
                              
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            child: FlatButton(
                              child: Text(
                                "Save",
                                style: TextStyle(fontSize: 18),
                              ),
                              textColor: Colors.white,
                              padding: EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              color: Colors.redAccent,
                              onPressed: () async {
                                _databaseService.updateUserDetails(firstNameController.text, lastNameController.text, emailController.text, mobilenoController.text);
                              },
                            ),
                          ),
                          Container(
                              alignment: Alignment.center,
                              child: FlatButton(
                                onPressed: () => { Navigator.push(context, MaterialPageRoute(builder: (context)=>changePass()))},
                                child: Text(
                                  "Change Password",
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 12),
                                ),
                              )),
                              Container(
                              alignment: Alignment.center,
                              child: FlatButton(
                                onPressed: () => { Navigator.push(context, MaterialPageRoute(builder: (context){
                                  var addressPage = AddressPage();
                                  return addressPage;
                                }))},
                                child: Text(
                                  "Add Address",
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 12),
                                ),
                              )),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red),
                          ),
                        ])))));
  }
}
