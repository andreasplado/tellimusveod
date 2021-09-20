import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text('Kontakt'),
          ],
        ),


        backgroundColor: Colors.blue[400],
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
            child: IconButton(
              icon: Icon(
                Icons.call,
                size: 32.0,
              ),
              onPressed: () {
              },
            ),
          ),
        ],
      ),
    );
  }
}