import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyContacts extends ChangeNotifier {
  List<String> _contacts = [];

  List<String> get contacts => _contacts;

  Future<void> updateNewContactList(List<String> contacts) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("numbers", contacts);
    _contacts = contacts;
    notifyListeners();
  }

  Future<List<String>> checkForContacts() async {
    print('fetching');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> contacts = prefs.getStringList("numbers") ?? [];
    _contacts = contacts;
    print('fetching successful');
    return contacts;
  }

  Future<void> saveContacts(List<Contact> selectedContacts) async {
    print('starting');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> numbers = prefs.getStringList("numbers") ?? [];

    for (Contact c in selectedContacts) {
      String entity = "";
      if (c.phones.isNotEmpty) {
        String refactoredNumber = refactorPhoneNumbers(c.phones.first.number);
        entity = "${c.displayName}***$refactoredNumber";
      } else {
        entity = "${c.displayName}***";
      }
      if (!numbers.contains(entity)) numbers.add(entity);
    }

    prefs.setStringList("numbers", numbers);
    _contacts = numbers;
    notifyListeners();
    print("Saved");
  }

  String refactorPhoneNumbers(String phone) {
    if (phone == "") {
      return "";
    }
    var newPhone = phone.replaceAll(RegExp(r"[^\name\w]"), '');
    if (newPhone.length == 13) {
      newPhone = "+" + newPhone.substring(0, newPhone.length);
    }
    if (newPhone.length == 12) {
      newPhone = "+977" + newPhone.substring(1, newPhone.length);
    }
    if (newPhone.length > 12) {
      var start2Number = newPhone.substring(0, 2);
      if (start2Number == "977") {
        newPhone = "+" + newPhone.substring(0, 12);
      }
    }

    return newPhone;
  }
}
