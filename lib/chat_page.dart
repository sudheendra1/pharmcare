import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmcare/Doctor.dart';
import 'package:pharmcare/chat_bubble.dart';
import 'package:pharmcare/chat_service.dart';

class chat_page extends StatefulWidget {
  const chat_page(
      {super.key,  required this.receiveruserid,required this.doc_name,required this.pat_name});

  //final receiveremail;
  final receiveruserid;
  final doc_name;
  final pat_name;

  @override
  State<StatefulWidget> createState() {
    return _chatpagestate();
  }

}

class _chatpagestate extends State<chat_page>{
  final TextEditingController msgcontroller = TextEditingController();
  final chatservice _chatservice= chatservice();
  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String username="username";

  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    _firestore.collection("users").doc(_firebaseAuth.currentUser!.uid).get().then((value){
      setState(() {
        username=value.data()?['username'];

      });
    });

  }

  void sendmessage()async{
    if(msgcontroller.text.isNotEmpty){
      await _chatservice.sendmessage(widget.receiveruserid, msgcontroller.text,widget.doc_name,widget.pat_name==null?"patient":widget.pat_name,username);
      msgcontroller.clear();
    }

}
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () async {
        Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    Doctor(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Color.fromARGB(100, 125, 216, 197),),
        body: Column(children: [
          Expanded(child: _builMessagelist(),),
          _buildMessageinput(),
          SizedBox(height: 25,),
        ],),),
    );
  }

  Widget _builMessagelist(){
    return StreamBuilder(stream: _chatservice.getMessages(widget.receiveruserid, _firebaseAuth.currentUser!.uid),
        builder:(context,snapshot){
      if(snapshot.hasError){
        return Text('error'+snapshot.error.toString());
      }
      if(snapshot.connectionState==ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }
      return ListView(
        children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
      );
    });
  }

  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String,dynamic> data = document.data() as Map<String,dynamic>;
    print(data['SenderId']);

    var alignment = (data['SenderId']==_firebaseAuth.currentUser!.uid)
    ?Alignment.centerRight:
        Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
        child: Column(
          crossAxisAlignment: (data['SenderId']==_firebaseAuth.currentUser!.uid)?CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [Text(data['SenderName']),
          SizedBox(height: 4,),
          chatbubble(message: data['message'])],
        ),
      ),
    );
  }
  Widget _buildMessageinput(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,),
      child: Row(children: [
        Expanded(child: TextField(
          controller: msgcontroller,
        decoration: InputDecoration(hintText: 'Enter message'),

        obscureText:false,
        ),
      ),
        IconButton(onPressed: sendmessage, icon: Icon(Icons.arrow_upward,size: 40,))
      ],
      ),
    );
  }

}