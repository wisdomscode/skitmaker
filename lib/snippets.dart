import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  // TO GET THE VALUES OF A NEWLY CREATED COLLECTION
  // await FirebaseFirestore.instance.collection("products").add({
  //   "name": "Mango",
  //   "price": 20
  // }).then((DocumentReference doc) {
  //   print("New product id is ${doc.id}, name is ${doc.name} and  price is ${doc.price}");
  // });

  @override
  Widget build(BuildContext context) {
    // To count items collections
    Future<AggregateQuerySnapshot> countItems =
        FirebaseFirestore.instance.collection('users').count().get();
    return Scaffold(
        body: Center(
      child: FutureBuilder<AggregateQuerySnapshot>(
        future: countItems,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Oops! something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            int docCount = snapshot.data!.count;
            return Text(
              docCount.toString(),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    ));
  }
}
