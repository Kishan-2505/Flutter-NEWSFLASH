import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.black,
          brightness: Brightness.dark,
          elevation: 20,
          //textTheme: Theme.of(context).textTheme,
          iconTheme: Theme.of(context).iconTheme,
        ),
      ),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            leading: Icon(Icons.local_library,color: Colors.white,),
            title: Text(
              'NewsFeed',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.normal,
                fontSize: 30,
                backgroundColor: Colors.transparent,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
    );
  }
}
