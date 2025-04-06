import 'package:e_commerce/service/database.dart';
import 'package:e_commerce/service/share_pref.dart';
import 'package:e_commerce/widgets/app_widget.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  String image, name, detail, price;

  DetailPage({
    required this.detail,
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int currentQuantity = 1, total = 0;
  String? id;

  @override
  void initState() {
    super.initState();
    onTheLoad();
    total = int.parse(widget.price);
  }

  getTheSharedPref() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  onTheLoad() async {
    await getTheSharedPref();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            ),
            Image.asset(
              "images/salad2.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name, style: AppWidget.samiBoolTextStye()),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (currentQuantity > 1) {
                      setState(() {
                        --currentQuantity;
                        total -= int.parse(widget.price);
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(Icons.remove, color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  currentQuantity.toString(),
                  style: AppWidget.samiBoolTextStye(),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentQuantity++;
                      total += int.parse(widget.price);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(widget.detail, maxLines: 3, style: AppWidget.lightTextStye()),
            SizedBox(height: 30),
            Row(
              children: [
                Text("Delivery time", style: AppWidget.samiBoolTextStye()),
                SizedBox(width: 20),
                Icon(Icons.alarm, color: Colors.black),
                Text("30 min", style: AppWidget.samiBoolTextStye()),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Price ", style: AppWidget.samiBoolTextStye()),
                      Text(
                        "\$" + total.toString(),
                        style: AppWidget.headlineTextStye(),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> addFoodtoCart = {
                        "Name": widget.name,
                        "Quantity": currentQuantity.toString(),
                        "Total": total.toString(),
                        "Image": widget.image,
                      };
                      await DatabaseMethods().addToCart(addFoodtoCart, id!);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.orangeAccent,
                          content: Text(
                            "Food Added to Cart",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      );

                      setState(() {
                        currentQuantity = 1;
                        total = int.parse(widget.price);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Add to cart",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(color: Colors.black),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
