import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as per;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> requestSmsPermission(String number,String msg) async {
  List<String> numbers = [];
  final status = await per.Permission.sms.request();
  if (number == '-1111') {
    print('hello');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> contacts = prefs.getStringList("numbers") ?? [];

    numbers = contacts.map((e) => e.split('***')[1]).toList();
  } else {
    numbers = [number];
  }

  print(number);

  Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  // Check if location services are enabled
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  // Check and request location permission
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  // Get the device's location
  _locationData = await location.getLocation();
  print(_locationData);

  if (status.isGranted) {
    for (String num in numbers) {
      final uri =
          'sms:$num?body=$msg https://maps.google.com/?q=${_locationData.latitude},${_locationData.longitude}';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        print('Permission denied for number: $num');
      }
    }
  }
}
