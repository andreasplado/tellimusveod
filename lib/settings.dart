import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:place_tracker/model/settings-offline.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'errorpage/failed_settings.dart';
import 'errorpage/not_retrieved_settings.dart';
import 'errorpage/settings_not_defined.dart';

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
                icon: const Icon(
                  Icons.save,
                  size: 32.0,
                ),
                onPressed: () {
                  SettingsData settingsData = SettingsData(language: "language", useDarkTheme: true, useBiometricAuthentication: true);
                  saveSwitchState(settingsData);
                },
              ),
            ),
          ],
        ),
        body: FutureBuilder<SettingsData>(
          future: getSwitchState(),
          builder:(context, AsyncSnapshot<SettingsData> settingsData) {
            if (settingsData.hasData) {
              return const DefaultSettings();
            } else if (settingsData.hasError) {
              return const FailedSettings();
            } else {
              return const SettingsNotDefined();
            }
            return SettingsNotDefined();
          },
        ));
  }

  Future<void> saveSwitchState (SettingsData settingsData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("darkTheme", settingsData.isdarktheme);
    prefs.setString("language", settingsData.language);
    prefs.setBool("isBiomethricAuthentication", settingsData.useBiometricAuthentication);
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
