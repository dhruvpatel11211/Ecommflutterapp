import 'package:immaculateflutterecomm/screens/Cart/ProductDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:immaculateflutterecomm/models/drawer.dart';
class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  List items = ['hello','world'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Center(
          child: Title(
            color: Colors.blueAccent,
            child: Text('WishList'),
          ),
        ),
      ),
      drawer: drawer(),
      body: Container(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
          return Dismissible(
            key: Key(items[index]),
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction)
            {
              setState(() {
                items.removeAt(index);
              });
            },
            direction: DismissDirection.endToStart,
            child: FlatButton(
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails()));
              },
              child: Card(
                elevation: 5,
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
                            fit: BoxFit.cover,
                            image: NetworkImage('https://images.squarespace-cdn.com/content/v1/59d2bea58a02c78793a95114/1589398875141-QL8O2W7QS3B4MZPFWHJV/ke17ZwdGBToddI8pDm48kBVDUY_ojHUJPbTAKvjNhBl7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QHyNOqBUUEtDDsRWrJLTmmV5_8-bAHr7cY_ioNsJS_wbCc47fY_dUiPbsewqOAk2CqqlDyATm2OxkJ1_5B47U/image-asset.jpeg'),
                          )
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: 100,
                          child: Padding(padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(items[index]),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                child: Container(
                                  width: 70,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.teal),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Text('20000 Rs',textAlign: TextAlign.center,),
                                ),
                              ),
                              Container(
                                width: 260,
                                child: Text('Item added on (date)',style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255,48,48,54),
                                ),),
                              )
                            ],
                          ),),
                        ),
                      ),
                      Container(
                        height: 100,
                          child: FlatButton(onPressed: (){}, child: Icon(Icons.shopping_cart)))
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
