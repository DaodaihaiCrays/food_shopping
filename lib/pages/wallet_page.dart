import 'package:e_commerce/service/database.dart';
import 'package:e_commerce/service/share_pref.dart';
import 'package:e_commerce/widgets/app_widget.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String? wallet, id;
  int? _wallet_add = 0;
  int? add;
  TextEditingController amountcontroller = new TextEditingController();

  getthesharedpref() async {
    wallet = await SharedPreferenceHelper().getUserWallet();
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  updateWallet() async {
    if (_wallet_add! > 0 || _wallet_add != null) {
      double currentWallet = double.tryParse(wallet ?? "0") ?? 0;
      double updatedWallet = currentWallet + _wallet_add!;

      await SharedPreferenceHelper().saveUserWallet(updatedWallet.toString());
      await DatabaseMethods().updateUserWallet(id!, updatedWallet.toString());

      setState(() {
        wallet = updatedWallet.toString();
        _wallet_add = 0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
          (SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Add Money Successfully",
              style: TextStyle(fontSize: 20.0),
            ),
          )),
        );
    }
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Text("Wellet", style: AppWidget.headlineTextStye()),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
              child: Row(
                children: [
                  Image.asset(
                    "images/wallet.png",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 40.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your Wallet", style: AppWidget.lightTextStye()),
                      SizedBox(height: 5.0),
                      Text("\$" + wallet!, style: AppWidget.boldTextStye()),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text("Add Money", style: AppWidget.boldTextStye()),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _wallet_add = _wallet_add! + 100;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFE9E2E2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("\$100", style: AppWidget.samiBoolTextStye()),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _wallet_add = _wallet_add! + 500;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFE9E2E2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("\$500", style: AppWidget.samiBoolTextStye()),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _wallet_add = _wallet_add! + 1000;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFE9E2E2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("\$1000", style: AppWidget.samiBoolTextStye()),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _wallet_add = _wallet_add! + 2000;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFE9E2E2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("\$2000", style: AppWidget.samiBoolTextStye()),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Money You Add: ",
                    style: AppWidget.boldTextStye(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Text(
                    "\$${_wallet_add ?? 0}",
                    style: AppWidget.boldTextStye(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 6,
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFFff5c30),
                ),
                onPressed: () async {
                  await updateWallet();
                },
                child: Text('Add Money', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
