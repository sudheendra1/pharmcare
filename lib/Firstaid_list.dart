import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmcare/F_item.dart';

class firstaidlist extends StatefulWidget{
  const firstaidlist({super.key});

  @override
  State<StatefulWidget> createState() {
    return _firstaidliststate();
  }

}

class _firstaidliststate extends State<firstaidlist>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(body: StreamBuilder(
     stream:FirebaseFirestore.instance
         .collection('First_Aids').snapshots(),

     builder: (context,
         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
       if (snapshot.connectionState == ConnectionState.waiting) {
         return const Center(
           child: CircularProgressIndicator(),
         );
       }
       return ListView.builder(
           itemCount: snapshot.data!.docs.length,
           itemBuilder: (context, index) => Faiditem(snap: snapshot.data!.docs[index].data(),));
     },
   ),);
  }

}