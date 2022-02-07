// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getUserData() async {

    var response= await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users= [];
    for(var u in jsonData){
      User user= User(userName: u['name'], mail: u['mail'],name: u['name']);
      users.add(user);
    }
    print(users.length);
    //print('Monim');
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
        body: Container(
          child: Card(child: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot){
              if(snapshot.data == null){
                return Container(child: Center(
                  child: Text("Loading......"),
                ),);
              }else return ListView.builder(itemCount:   snapshot.data.length , itemBuilder: (context , i){
                return ListTile(
                  title: Text(snapshot.data[i].name),
                );
              });
            },
          ),),
        ),
        // body: Center(child: ElevatedButton(
        //   child: Text('Click Me'),
        //   onPressed:(){
        //     // print('Sina');
        //     getUserData();
        //   },
        // ),),
      ),
    );
  }
}
