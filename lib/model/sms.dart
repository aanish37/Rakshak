import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> requestSmsPermission() async {
  final status = await Permission.sms.request();
  if (status.isGranted) {
    final uri = 'sms:9866134714?body=message';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      print('permission denied');
    }
  }
}
