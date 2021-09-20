import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text('Seaded'),
          ],
        ),


        backgroundColor: Colors.blue[400],
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
            child: IconButton(
              icon: Icon(
                Icons.save,
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
