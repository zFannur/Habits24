import 'package:shared_preferences/shared_preferences.dart';

class AppSavedVariables {
  AppSavedVariables();

  Future<void> saveLastExportDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastExportDate', DateTime.now().toString());
  }

  Future<DateTime?> getLastExportDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastExportDateString = prefs.getString('lastExportDate');
    if (lastExportDateString != null) {
      return DateTime.parse(lastExportDateString);
    }
    return null;
  }

  Future<void> deleteLastExportDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('lastExportDate');
  }
}