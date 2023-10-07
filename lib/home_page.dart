import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:pharmcare/Doctor.dart';
import 'package:pharmcare/Medicines_info.dart';
import 'package:pharmcare/Search.dart';
import 'package:pharmcare/barcode_scan.dart';
import 'package:pharmcare/firstaid_data.dart';
import 'package:pharmcare/profile.dart';
import 'package:pharmcare/chatbot.dart';
import 'package:pharmcare/Firstaid_list.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _homepagestate();
  }
}

class _homepagestate extends State<Homepage> {
  int _currentindex=0;
  String? Scanresult;
  Future scanbarcode()async{

    try{
      Scanresult= await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException{
      Scanresult= 'Failed to get platform version';
    }
    if(!mounted) return;
    setState(() {
      Scanresult=Scanresult;
      Navigator.push(context, PageRouteBuilder(pageBuilder: (context,animation1,animation2)=>Bar(bar:Scanresult),transitionDuration: Duration.zero,reverseTransitionDuration: Duration.zero));

      if (kDebugMode) {
        print(Scanresult);
      }
    });
  }
  FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Exit'),
              content: const Text('Are you sure you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text('Yes', style: TextStyle(color: Colors.red),),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
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
          appBar: AppBar(
              backgroundColor: Color.fromARGB(100, 125, 216, 197),
              title: SizedBox(
                height: 40,
                width: 300,
                child: Text("Homepage")
              ),
              actions: [
                TextButton.icon(
                  onPressed: () {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (context,animation1,animation2)=>SearchPage(),transitionDuration: Duration.zero,reverseTransitionDuration: Duration.zero));},
                  icon: Icon(Icons.search, color: Colors.blue),
                  label: Text('Search medicines', style: TextStyle(color: Colors.blue)),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    side: BorderSide(color: Colors.blue),
                  ),
                ),
                IconButton(
                  onPressed: scanbarcode,
                  icon: Icon(Icons.barcode_reader),
                ),
              ]),
          body: Column(
            children: [
              GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>medicineslist()));},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Container(
                    height: 100,
                    width: 390,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0), // Rounded corners
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Image.asset(
                            "assets/images/img.png",
                            height: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                          child: Column(
                            children: [
                              Text('Most searched medicines'),
                              Text("get details about medicines")
                            ],
                          ),
                        ),
                        /*Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                          child: ElevatedButton(
                            child: Text("See All"),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              foregroundColor: Colors.black,
                              backgroundColor: Color.fromARGB(100, 125, 216, 197),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Doctor()));},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Container(
                    height: 100,
                    width: 390,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0), // Rounded corners
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Image.asset(
                            "assets/images/img_1.png",
                            height: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                          child: Column(
                            children: [
                              Text('Consult Doctor'),
                              Text("Advice from virtual doctor")
                            ],
                          ),
                        ),
                        /*Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                          child: ElevatedButton(
                            child: Text("Visit"),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              foregroundColor: Colors.black,
                              backgroundColor: Color.fromARGB(100, 125, 216, 197),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>firstaidlist()));},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Container(
                    height: 100,
                    width: 390,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0), // Rounded corners
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Image.asset(
                            "assets/images/img_2.png",
                            height: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                          child: Column(
                            children: [
                              Text('First Aids'),
                              Text("First aid tips for problems")
                            ],
                          ),
                        ),
                        /*Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                          child: ElevatedButton(
                            child: Text("Get"),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              foregroundColor: Colors.black,
                              backgroundColor: Color.fromARGB(100, 125, 216, 197),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Container(
                  width: 390,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(100, 125, 216, 197),
                    borderRadius: BorderRadius.circular(12.0), // Rounded corners
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Faiddata(fname: "CPR")));},
                              child: Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(100, 125, 216, 197),
                                  borderRadius: BorderRadius.circular(12.0),
                                  // Rounded corners
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/img_3.png",
                                      height: 85,
                                      width: 110,
                                    ),
                                    Text(('CPR'))
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Faiddata(fname: "Cuts & Grazes")));},
                              child: Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(100, 125, 216, 197),
                                  borderRadius: BorderRadius.circular(12.0),
                                  // Rounded corners
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/img_4.png",
                                      height: 85,
                                      width: 110,
                                    ),
                                    Text(('Cuts & Grazes'))
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Faiddata(fname: "Burns")));},
                              child: Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(100, 125, 216, 197),
                                  borderRadius: BorderRadius.circular(12.0),
                                  // Rounded corners
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/img_5.png",
                                      height: 85,
                                      width: 110,
                                    ),
                                    Text(('Burns'))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Faiddata(fname: "Bee Stings")));},
                              child: Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(100, 125, 216, 197),
                                  borderRadius: BorderRadius.circular(12.0),
                                  // Rounded corners
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/img_6.png",
                                      height: 85,
                                      width: 110,
                                    ),
                                    Text(('Bee Stings'))
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Faiddata(fname: "Sprains")));},
                              child: Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(100, 125, 216, 197),
                                  borderRadius: BorderRadius.circular(12.0),
                                  // Rounded corners
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/img_7.png",
                                      height: 85,
                                      width: 110,
                                    ),
                                    Text(('Sprains'))
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Faiddata(fname: "Leech Attacks")));},
                              child: Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(100, 125, 216, 197),
                                  borderRadius: BorderRadius.circular(12.0),
                                  // Rounded corners
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/Sucking_leech.jpg",
                                      height: 85,
                                      width: 110,
                                    ),
                                    Text(('Leech attacks'))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Faiddata(fname: "Splinters")));},
                              child: Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(100, 125, 216, 197),
                                  borderRadius: BorderRadius.circular(12.0),
                                  // Rounded corners
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/img_8.png",
                                      height: 85,
                                      width: 110,
                                    ),
                                    Text(('Splinter'))
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Faiddata(fname: "Animal Bites")));},
                              child: Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(100, 125, 216, 197),
                                  borderRadius: BorderRadius.circular(12.0),
                                  // Rounded corners
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/img_9.png",
                                      height: 85,
                                      width: 110,
                                    ),
                                    Text(('Animal Bites'))
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Faiddata(fname: "Nosebleeds")));},
                              child: Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(100, 125, 216, 197),
                                  borderRadius: BorderRadius.circular(12.0),
                                  // Rounded corners
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/img_11.png",
                                      height: 85,
                                      width: 110,
                                    ),
                                    Text(('Nosebleeds'))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
