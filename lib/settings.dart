import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:place_tracker/model/settings-offline.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'errorpage/failed_settings.dart';
import 'errorpage/not_retrieved_settings.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDarkTheme = false;
  String language = "";
  bool isBiomethricAuthentication = false;

  @override
  void initState() {
    super.initState();
    getThemeState().then((value) => isDarkTheme = value);
  }

  Future<bool> getThemeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return (prefs.getBool("darkTheme") == true) ? true : false;
  }

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
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: FutureBuilder<bool>(
          future: getSwitchState(),
          builder:(BuildContext context, AsyncSnapshot<bool> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              NotRetrievedSettings();
            } else if (snapshot.hasError) {
              FailedSettings();
            } else {
              return SettingsList(
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
                          enabled: false,
                          leading: Icon(Icons.phone_android),
                          onToggle: (bool value) {
                            setState(() {
                              saveSwitchState(value);
                            });
                          },
                          switchValue: true)
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
              );
            }
          },
        ));
  }

  Future<void> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("darkTheme", value);
  }

  Future<SettingsData> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isDarkTheme = prefs.getBool("darkTheme")!;
    language = (prefs.getString("language") == null) ? "" : "" ;
    isBiomethricAuthentication = prefs.getBool("isBiomethricAuthentication")!;


    SettingsData settingsData = new SettingsData(language: language, useDarkTheme: isDarkTheme, useBiometricAuthentication: isBiomethricAuthentication);

    return settingsData;
  }
}

class MyNotifier with ChangeNotifier {
  MyNotifier() {
    // TODO: start some request
  }
}
