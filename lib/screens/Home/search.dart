import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('products')
        .where('searchKey',
        isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}
class Searchbar extends StatefulWidget {

  @override
  _SearchbarState createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
          queryResultSet.forEach((element) {
            if (element['name'].startsWith(capitalizedValue)) {
              setState(() {
                tempSearchStore.add(element);
              });
            }
          });

        }
      });
    }
    else {
      tempSearchStore = [];
            queryResultSet.forEach((element) {
              if (element['name'].startsWith(capitalizedValue)) {
                setState(() {
                  tempSearchStore.add(element);
          });
        }
      });
    }
  }
  TextEditingController searchcontrol=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(padding:EdgeInsets.all(10),
          child: TextField(
            onChanged: (val){
              initiateSearch(val);
            },
            controller: searchcontrol,
            decoration: InputDecoration(
              prefixIcon: IconButton(icon: Icon(Icons.arrow_back), onPressed:(){ searchcontrol.clear();}),
              contentPadding: EdgeInsets.only(left: 25),
              hintText: 'Search by name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: 200,
            width: 200,
            child: ListView.builder(
              itemCount: tempSearchStore.length,
              itemBuilder:(context,index){
                return Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.search),
                    title: Text(tempSearchStore[index]['name']),

                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
