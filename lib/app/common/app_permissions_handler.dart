import 'package:permission_handler/permission_handler.dart';

class AppPermissionsHandler {
  AppPermissionsHandler();

  Future<void> requestStoragePermission() async {
    var status = await Permission.manageExternalStorage.status;
    print(status);

// Если разрешение отклонено, запросить его
    if (status.isDenied) {
      // Можно показать обоснование запроса разрешения на Android
      // if (await Permission.storage.shouldShowRequestRationale) {
      //   // Показать обоснование использования разрешения на хранение
      //   // Например: Объяснить, почему приложению нужен доступ к хранению
      // }

      // Запросить разрешение на хранение
      var result = await Permission.manageExternalStorage.request();

      // Проверить новый статус разрешения
      if (result.isGranted) {
        // Разрешение предоставлено
      } else {
        // Разрешение отклонено
      }
    }

    var statusStorage = await Permission.storage.status;
    print(statusStorage);

// Если разрешение отклонено, запросить его
    if (statusStorage.isDenied) {
      // Можно показать обоснование запроса разрешения на Android
      // if (await Permission.storage.shouldShowRequestRationale) {
      //   // Показать обоснование использования разрешения на хранение
      //   // Например: Объяснить, почему приложению нужен доступ к хранению
      // }

      // Запросить разрешение на хранение
      var result = await Permission.storage.request();

      // Проверить новый статус разрешения
      if (result.isGranted) {
        // Разрешение предоставлено
      } else {
        // Разрешение отклонено
      }
    }
  }
}