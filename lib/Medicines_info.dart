import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pharmcare/medlist_temp.dart';

class medicineslist extends StatefulWidget{
  const medicineslist({super.key});

  @override
  State<StatefulWidget> createState() {
    return _medicinesliststate();
  }

}

class _medicinesliststate extends State<medicineslist>{
  Stream<List<dynamic>> fetchAllProducts(int limit) async* {
    final response = await http.get(Uri.parse('http://192.168.0.229:5000/all_products?limit=$limit'));

    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);
      if (decodedResponse is List) {
        yield decodedResponse;
      } else {
        throw Exception(
            'Expected a list but got ${decodedResponse.runtimeType}');
      }
    }else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(elevation: 0.0, title: Text("product_name"),

      backgroundColor: Color.fromARGB(
          100, 125, 216, 197),),
      body: StreamBuilder<List<dynamic>>(
        stream: fetchAllProducts(500),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found.'));
          } else {
            List<dynamic> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];
                return medtemp(medicine: product);
              },
            );
          }
        },
      ),);
  }

}