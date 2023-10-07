import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmcare/home_page.dart';
import 'package:pharmcare/profile.dart';

class Chatbot extends StatefulWidget{
  const Chatbot({super.key});

  @override
  State<StatefulWidget> createState() {
    return _chatbotstate();
  }

}

class _chatbotstate extends State<Chatbot>{
  int _currentindex=0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async { Navigator.push(context, PageRouteBuilder(pageBuilder: (context,animation1,animation2)=>Homepage(),transitionDuration: Duration.zero,reverseTransitionDuration: Duration.zero)); return true; },
      child: Scaffold(body: Text('hi'),
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
        ),),
    );
  }

}