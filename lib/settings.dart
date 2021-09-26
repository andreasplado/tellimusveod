import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

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
      body: SettingsList(
        sections: [
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'Põhiseaded',
            tiles: [
              SettingsTile(
                title: 'Keel',
                subtitle: 'Inglise',
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Kasuta tumedat teemat',
                leading: Icon(Icons.phone_android),
                onToggle: (value) {
                  setState(() {
                  });
                }, switchValue: true,
              ),
            ],
          ),
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'Turvaseaded',
            tiles: [
              SettingsTile(
                title: 'Muuda parooli',
                subtitle: 'Sea uus parool',
                leading: Icon(Icons.password),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Kasuta biomeetrilist autentimist',
                leading: Icon(Icons.fingerprint),
                switchValue: true,
                onToggle: (value) {},
              ),
              SettingsTile(
                title: 'Kasutaja kustutamine',
                subtitle: 'Kustuta kasutaja',
                leading: Icon(Icons.delete_forever),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  void setState(Null Function() param0
      ) {}
}
