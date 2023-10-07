import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Doctor extends StatefulWidget{
  const Doctor({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Doctorstate();
  }

}

class _Doctorstate extends State<Doctor>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("Doctors list"),);
  }

}