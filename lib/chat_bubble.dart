import 'package:flutter/cupertino.dart';

class chatbubble extends StatelessWidget{
  const chatbubble({super.key,required this.message});
  final message;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(12) ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromARGB(100, 125, 216, 197)
      ),
      child: Text(
        message,
        style: TextStyle(fontSize: 16,color: Color.fromARGB(100, 0, 0, 0)),
      ),
    );
  }

}