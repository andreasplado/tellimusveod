import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:settings_ui/settings_ui.dart';

// Define a custom Form widget.
class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  ContactState createState() {
    return ContactState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class ContactState extends State<Contact> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
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
                Icons.save,
                size: 32.0,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'Andmed',
            tiles: [
              SettingsTile(
                title: 'Telefon',
                subtitle: '+37258802867',
                leading: Icon(Icons.phone),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: 'Email',
                subtitle: 'andreasplado@gmail.com',
                leading: Icon(Icons.email),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
