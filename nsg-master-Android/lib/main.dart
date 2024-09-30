import 'package:flutter/material.dart';
import 'package:nsg/selectBuildling.dart';
import 'package:nsg/signuppage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initializeDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'nsdDB.db');

  return await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE users ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'name TEXT, '
            'user_id INTEGER'
            ')',
      );
      print("Table created successfully");
    },
  );
}

late Database database;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = await initializeDatabase();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignupPage(),
    );
  }
}
