import 'package:cash_flow_project/ui/home.dart';
import 'package:flutter/material.dart';

import 'repository/dbcontext.dart';

void main() async {
  await DbContext().initDB("cashflowproject.db");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cash Flow Project',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          textTheme: TextTheme(
            body1: TextStyle(
              color: Color(0xFF4F4F4F),
            ),
          )),
      home: MyHomePage(title: 'Cash Flow Project'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Home(),
    );
  }
}
