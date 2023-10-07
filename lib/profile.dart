import 'dart:core';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmcare/chatbot.dart';
import 'package:pharmcare/home_page.dart';
import 'package:pharmcare/login_page.dart';
import 'package:pharmcare/image_picker.dart';


var user = FirebaseAuth.instance.currentUser!;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() {
    return _profilestate();
  }
}

class _profilestate extends State<Profile> {
  void signout() async {

    //await GoogleSignIn().disconnect();
    await FirebaseAuth.instance.signOut();

    await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (c) => const Loginpage()),(route)=>false);
  }
  Uint8List? _selectedimage;
  int _currentindex=0;

  @override
  Widget build(BuildContext context) {
    return

      WillPopScope(
        onWillPop: () async { Navigator.push(context, PageRouteBuilder(pageBuilder: (context,animation1,animation2)=>Homepage(),transitionDuration: Duration.zero,reverseTransitionDuration: Duration.zero)); return true; },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: const Text('Profile'),
            backgroundColor: Color.fromARGB(100, 125, 216, 197),
          ),
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

          body:
          Container(

            padding: EdgeInsets.fromLTRB(20, 30, 30, 30),
            child: Column(


              children: [
                imagepicker(
                  onpickedimage: (pickedimage) async {
                    _selectedimage = pickedimage;
                    final storageref = FirebaseStorage.instance
                        .ref()
                        .child('User-images')
                        .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');
                    TaskSnapshot snap = await storageref.putData(_selectedimage!);
                    String imageurl = await snap.ref.getDownloadURL();

                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .update({'image_url': imageurl});
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
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
                        return Column(
                          children: [Row(children: [const Text('USERNAME:',style: TextStyle(fontWeight: FontWeight.bold)),SizedBox(width: 5,),Text(doc['username'],maxLines: 1,),],),

                            const SizedBox(
                              height: 20,
                            ),
                            Row(crossAxisAlignment: CrossAxisAlignment.start,children: [const Text('Date of Birth:',style: TextStyle(fontWeight: FontWeight.bold)),SizedBox(width: 5,),

                              Expanded(child: Text(doc['DOB'],maxLines: 4,overflow: TextOverflow.clip,)),

                            ],),

                            const SizedBox(
                              height: 20,
                            ),
                            Row(children: [const Text('Email-Id:',style: TextStyle(fontWeight: FontWeight.bold)),SizedBox(width: 5,),Text(doc['email_id'],maxLines: 1,),],),

                            const SizedBox(
                              height: 20,
                            ),
                            Row(children: [const Text('Gender:',style: TextStyle(fontWeight: FontWeight.bold)),SizedBox(width: 5,),Text(doc['gender'],maxLines: 1,),],),

                            const SizedBox(
                              height: 20,
                            ),

                            Row(children: [const Text('Allergies:',style: TextStyle(fontWeight: FontWeight.bold)),SizedBox(width: 5,),Text(doc['Allergies'],maxLines: 1,),],),



                            const SizedBox(
                              height: 20,
                            ),
                            Row(crossAxisAlignment: CrossAxisAlignment.start,children: [const Text('Diseases:',style: TextStyle(fontWeight: FontWeight.bold),),SizedBox(width: 5,), Text(doc['Diseases'],maxLines: 1),],),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),



                Expanded(
                  child: TextButton(
                      onPressed: () {
                        signout();
                        // Navigator.of(context).pop();
                      },
                      child: const Text('Logout')),
                )
              ],
            ),
          ),


        ),

      );
  }
}
