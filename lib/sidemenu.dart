import 'package:flutter/material.dart';

import 'contact.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              'Tellimusveod',
              style: TextStyle(color: Colors.black, fontSize: 25),

            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('icon/icon.png'))),
          ),
          ListTile(
            title: const Text('Seaded'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Kontakt'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (context) => const Contact()),
              );
              // ...
            },
          ),
        ],

      ),
    );
  }
}