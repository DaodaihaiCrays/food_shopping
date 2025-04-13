import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/pages/detail_page.dart';
import 'package:e_commerce/pages/search_page.dart';
import 'package:e_commerce/service/database.dart';
import 'package:e_commerce/widgets/app_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool icecream = false, pizza = true, salad = false, burger = false;
  String foodChoice = "Pizza";
  Stream? foodItemStream;

  onTheLoad() async {
    foodItemStream = await DatabaseMethods().getFoodItem("Pizza");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onTheLoad();
  }

  Widget allItemsVertically() {
    return StreamBuilder(
      stream: foodItemStream,
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

  Widget allItems() {
    return StreamBuilder(
      stream: foodItemStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
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
                    margin: EdgeInsets.all(5),
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "images/avt_default.png",
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              ds["Name"],
                              style: AppWidget.samiBoolTextStye(),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Fresh and healthy",
                              style: AppWidget.lightTextStye(),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "\$" + ds["Price"],
                              style: AppWidget.samiBoolTextStye(),
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 60, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hello Craysis', style: AppWidget.boldTextStye()),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap:() {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPage(kind: foodChoice)),
                      );
                      },
                      child: Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text("Delicous food", style: AppWidget.headlineTextStye()),
              Text(
                "Dicover and get greet food",
                style: AppWidget.lightTextStye(),
              ),
              SizedBox(height: 20),

              showItem(),

              SizedBox(height: 20),

              Container(height: 270, child: allItems()),

              SizedBox(height: 30),

              allItemsVertically(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            icecream = !icecream;
            pizza = false;
            salad = false;
            burger = false;

            foodItemStream = await DatabaseMethods().getFoodItem("Ice-cream");
            foodChoice = "Ice-cream";

            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: icecream ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/ice-cream.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: icecream ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            salad = !salad;
            pizza = false;
            icecream = false;
            burger = false;

            foodItemStream = await DatabaseMethods().getFoodItem("Salad");
            foodChoice = "Salad";

            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: salad ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/salad.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: salad ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            burger = !burger;
            pizza = false;
            salad = false;
            icecream = false;

            foodItemStream = await DatabaseMethods().getFoodItem("Burger");
            foodChoice = "Burger";

            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: burger ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/burger.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: burger ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            pizza = !pizza;
            salad = false;
            icecream = false;
            burger = false;

            setState(() {});

            foodItemStream = await DatabaseMethods().getFoodItem("Pizza");
            foodChoice = "Pizza";
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: pizza ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/pizza.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
