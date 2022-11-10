import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  final String userName;
  final String eMail;
  final String password;
  SecondPage(
      {required this.userName, required this.eMail, required this.password});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

TextStyle myTextStyle() {
  return TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("User Name: ${widget.userName}",style: myTextStyle(),),
            Text("E-Mail: ${widget.eMail}",style:  myTextStyle(),),
            Text("Password: ${widget.password}", style: myTextStyle(),),
            Image.asset(
              'lib/assets/success.jpg',
              width: 200,
            )
          ],
        ),
      ),
    );
  }
}
