import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/pages/bottom_nav.dart';
import 'package:e_commerce/pages/detail_page.dart';
import 'package:e_commerce/pages/home_page.dart';
import 'package:e_commerce/service/database.dart';
import 'package:e_commerce/widgets/app_widget.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.kind});

  final String kind;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchField = "";
  QuerySnapshot? foodItemStream;

  Widget allItemsVertically() {

    if (searchField.trim().isEmpty) {
      return Container(); 
    }

    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseMethods().searchFoodStream(widget.kind, searchField),
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => DetailPage(
                              detail: ds["Detail"],
                              image: ds["Image"],
                              name: ds["Name"],
                              price: ds["Price"],
                            ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Material(
                      borderRadius: BorderRadius.circular(14),
                      elevation: 5,
                      child: Container(
                        child: Row(
                          children: [
                            Image.asset(
                              "images/salad2.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 20),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    ds["Name"],
                                    style: AppWidget.samiBoolTextStye(),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    ds["Detail"],
                                    style: AppWidget.lightTextStye(),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "\$" + ds["Price"],
                                    style: AppWidget.samiBoolTextStye(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        searchField = value;
                        setState(() {
                          searchField = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search for food in ${widget.kind}",
                        hintStyle: AppWidget.lightTextStye(),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            allItemsVertically(),
          ],
        ),
      ),
    );
  }
}
