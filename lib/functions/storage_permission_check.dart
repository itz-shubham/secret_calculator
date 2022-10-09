import 'package:permission_handler/permission_handler.dart';

Future<void> storagePermissionCheck({
  required Function onPermissionGranted,
  required Function onPermissionDenied,
}) async {
  final status = await Permission.storage.request();
  if (status.isGranted) {
    onPermissionGranted();
  } else {
    onPermissionDenied();
  }
}
