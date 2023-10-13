  import 'package:permission_handler/permission_handler.dart';

void requstPremission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    var mangeStatus = await Permission.manageExternalStorage.status;
    if (!mangeStatus.isGranted) {
      await Permission.manageExternalStorage.request();
    }
  }
