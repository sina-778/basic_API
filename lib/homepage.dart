// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late int length;

  Future? getUserData() async {

    var response= await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users= [];
    for(var u in jsonData){
      User user= User(username: u['username'], email: u['email'],name: u['name']);
      users.add(user);
      inspect(user);
      print(user);
    }
    length = users.length;
    print(length);
    print(users.toList());
    return users;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Demo App"
            ),
          ),
        ),
        // body: Container(
        //   child: Card(child: FutureBuilder(
        //     future: getUserData(),
        //     builder: (context, snapshot){
        //       if(snapshot.data == null){
        //         return Container(child: Center(
        //           child: Text("Loading......"),
        //         ),);
        //       }else if(!snapshot.hasData){
        //         return Center(child: CircularProgressIndicator());
        //       }
        //       else return ListView.builder(
        //             itemCount: 15, //snapshot.data.length ,
        //             itemBuilder: (context , i){
        //         return ListTile(
        //           title: Text("List Item $i"),
        //         );
        //       });
        //     },
        //   ),),
        // ),
        body: Center(child: ElevatedButton(
          child: Text('Click Me'),
          onPressed:(){
            // print('Sina');
            getUserData();
          },
        ),),
      ),
    );
  }
}
