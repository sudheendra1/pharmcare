import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class medview extends StatelessWidget{
  const medview({super.key,required this.pn,required this.sc,required this.pm,required this.md,required this.se});
final pn;
  final sc;
  final pm;
  final md;
  final se;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(elevation: 0.0, title: Text(pn),

      backgroundColor: Color.fromARGB(
          100, 125, 216, 197),),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Medicine name: "+pn),
          SizedBox(height: 20,),
          Text("Manufactured by: "+pm),
          SizedBox(height: 20,),
          Text("Medicine info:"),
          SizedBox(height: 10,),
           Text(md),
          SizedBox(height: 20,),
          Text("Salt composition:"),
          SizedBox(height: 10,),
          Text(sc),
          SizedBox(height: 20,),
          Text("Side effects:"),
          SizedBox(height: 10,),
          Text(se),
              ],
      ),
    ),);
  }

}