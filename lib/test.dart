import 'dart:convert';
import 'dart:ffi';
import 'package:api_without_model/reusable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WithoutModel extends StatefulWidget {
  WithoutModel({Key? key}) : super(key: key);

  @override
  State<WithoutModel> createState() => _WithoutModelState();
}

class _WithoutModelState extends State<WithoutModel> {
  var data;

  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Without Model Api Integration'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            ReUsableRow(
                              title: 'name',
                              value: data[index]['name'].toString(),
                            ),
                            ReUsableRow(
                              title: 'Username',
                              value: data[index]['username'].toString(),
                            ),
                            ReUsableRow(
                              title: 'address',
                              value:
                                  data[index]['address']['street'].toString(),
                            ),
                            ReUsableRow(
                              title: 'Lat',
                              value: data[index]['address']['geo']['lat']
                                  .toString(),
                            ),
                            ReUsableRow(
                              title: 'Lat',
                              value: data[index]['address']['geo']['lng']
                                  .toString(),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
