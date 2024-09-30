import 'package:flutter/material.dart';
import 'package:nsg/selectBuildling.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';
void main() {
  runApp(SignupPage());
}

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  Future<bool> idValid(String id) async {
    final List<Map<String, dynamic>> result = await database.query(
      'users',
      where: 'user_id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }
  TextEditingController name = TextEditingController();
  TextEditingController id = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        backgroundColor: Colors.white,
        body:
         SingleChildScrollView(
           child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50), // Space from the top
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/nsglogo.png',
                        height: 100,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'National Security Guard',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Ministry of Home Affairs',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            ' Govt of India',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            'Sarvatra Sarvottam Suraksha',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(12),
                  child: Center(
                    child: Text(
                      '   Register   ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Name:',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                  controller: name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    } else if (!RegExp(
                                        r'^[A-Za-z0-9.]')
                                        .hasMatch(value)) {
                                      return "Please enter a valid name";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter your name',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                'ID:',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 45),
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your id';
                                    } else if (!RegExp(
                                        r'^[A-Za-z0-9.]')
                                        .hasMatch(value)) {
                                      return "Please enter a valid id";
                                    }
                                    return null;
                                  },
                                  controller: id,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your ID',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final isValid = formKey.currentState!.validate();

                      var uname = name.text;
                      var uid = id.text;
                      if (isValid) {
                        bool exists = await idValid(uid);
                        if (!exists) {
                          await database.insert('users', {
                            'name': uname,
                            'user_id': uid,
                          });
                          final rows = await database.query('users');
                          print('Inserted rows: $rows');
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) => SelectBuilding()));
                        } else {
                          Fluttertoast.showToast(
                            msg: "id already exists",
                            timeInSecForIosWeb: 2,
                            gravity: ToastGravity.BOTTOM,
                            fontSize: 18,
                            backgroundColor: Colors.black45,
                            textColor: Colors.white,
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: "Failed",
                          timeInSecForIosWeb: 2,
                          gravity: ToastGravity.BOTTOM,
                          fontSize: 18,
                          backgroundColor: Colors.black45,
                          textColor: Colors.white,
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      }
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
         ),
        ),
    );
  }
}
