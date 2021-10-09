import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../settings.dart';

class SettingsNotDefined extends StatelessWidget {
  const SettingsNotDefined({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SettingsList(
        sections: [
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'Seaded',
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
                    Settings settingstate = const Settings();
                }, switchValue: false,
              ),
            ],
          ),
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'Turvalisus',
            tiles: [
              SettingsTile(
                title: 'Kasuta biomeetrilist autentimist',
                subtitle: 'Luba biomeetriline autentimine',
                leading: Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Kasuta sõrmejälge',
                leading: Icon(Icons.fingerprint),
                switchValue: true,
                onToggle: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
