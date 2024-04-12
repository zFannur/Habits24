import 'package:share_plus/share_plus.dart';

class AppShare {
  AppShare();

  Future<void> sendMessageWithFile(String filePath) async {

    final result = await Share.shareXFiles([XFile(filePath)]);

    if (result.status == ShareResultStatus.dismissed) {
      throw 'Отменено';
    }
  }

}