import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  Future addToCart(Map<String, dynamic> cartInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("cart")
        .add(cartInfoMap);
  }

  updateUserWallet(String id, String amount) async {
    await FirebaseFirestore.instance.collection("users").doc(id).update({
      "Wallet": amount,
    });
  }

  Future addFoodItem(Map<String, dynamic> userInfo, String name) async {
    return await FirebaseFirestore.instance.collection(name).add(userInfo);
  }

  Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

  void deleteFoodCart(String id) async {
    var collection = FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("cart");

    var snapshots = await collection.get();

    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  Future<Stream<QuerySnapshot>> getFoodCart(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("cart")
        .snapshots();
  }

  Future<DocumentSnapshot?> getUserByEmail(String email) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance
            .collection("users")
            .where("Email", isEqualTo: email)
            .limit(1)
            .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first;
    } else {
      return null;
    }
  }
}
