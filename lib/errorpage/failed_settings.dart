import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class FailedSettings extends StatelessWidget {
  const FailedSettings({Key? key}) : super(key: key);

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
                  subtitle: 'Eesti',
                  leading: Icon(Icons.language),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: 'Kasuta tumedat teemat',
                  leading: Icon(Icons.phone_android),
                  onToggle: (value) {

                  }, switchValue: false,
                ),
              ],
            ),
            SettingsSection(
              titlePadding: EdgeInsets.all(20),
              title: 'Turvalisus',
              tiles: [
                SettingsTile(
                  title: 'Turvalisus',
                  subtitle: 'Kasuta biomeetrilist eutentimist',
                  leading: Icon(Icons.lock),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: 'Kasuta sõrmejälge',
                  leading: Icon(Icons.fingerprint),
                  switchValue: true,
                  onToggle: (value) {

                  },
                ),
              ],
            ),
          ],
        ),
    );
  }
}
