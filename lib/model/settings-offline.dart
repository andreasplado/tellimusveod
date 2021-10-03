class SettingsData {
  String language ="";
  bool useDarkTheme = false;
  bool useBiometricAuthentication = false;

  SettingsData(
      {required this.language, required this.useDarkTheme, required this.useBiometricAuthentication});

  bool get isdarktheme => this.useDarkTheme;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['useDarkTheme'] = this.useDarkTheme;
    data['useBiometricAuthentication'] = this.useBiometricAuthentication;
    return data;
  }
}