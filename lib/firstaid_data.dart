import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:pharmcare/First_aid.dart';
import 'package:pharmcare/chatbot.dart';
import 'package:pharmcare/home_page.dart';
import 'package:pharmcare/profile.dart';

class Faiddata extends StatefulWidget {
  const Faiddata({super.key, required this.fname});

  final fname;


  @override
  State<StatefulWidget> createState() {
    return _Faiddatastate();
  }

}

class _Faiddatastate extends State<Faiddata> {
  int _currentindex=0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async { Navigator.push(context, PageRouteBuilder(pageBuilder: (context,animation1,animation2)=>Homepage(),transitionDuration: Duration.zero,reverseTransitionDuration: Duration.zero)); return true; },
      child: Scaffold(
        appBar: AppBar(elevation: 0.0, title: Text(widget.fname),

        backgroundColor: Color.fromARGB(
            100, 125, 216, 197),),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentindex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(100, 125, 216, 197),
          iconSize: 20,
          unselectedFontSize: 10,
          selectedFontSize: 15,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
            BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: "Chatbot"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "PROFILE"),
          ],
          onTap: (index){
            if(index==0){
              Navigator.push(context, PageRouteBuilder(pageBuilder: (context,animation1,animation2)=>Homepage(),transitionDuration: Duration.zero,reverseTransitionDuration: Duration.zero));
            }
            if(index==1){
              Navigator.push(context, PageRouteBuilder(pageBuilder: (context,animation1,animation2)=>Chatbot(),transitionDuration: Duration.zero,reverseTransitionDuration: Duration.zero));
            }
            if(index==2){
              Navigator.push(context, PageRouteBuilder(pageBuilder: (context,animation1,animation2)=>Profile(),transitionDuration: Duration.zero,reverseTransitionDuration: Duration.zero));
            }
          },
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('First_Aids')
              .doc(widget.fname)
                            .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              Map<String, dynamic> doc =
              snapshot.data!.data() as Map<String, dynamic>;
              return First_aid(info: doc["info"],url: doc["url"],steps: doc["steps"], fname:widget.fname);
            }
          }
        ),),
    );
    }

}