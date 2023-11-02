import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fast_contacts/fast_contacts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PhoneMobile(),
    );
  }
}

class PhoneMobile extends StatefulWidget {
  @override
  _PhoneMobileState createState() => _PhoneMobileState();
}

class _PhoneMobileState extends State<PhoneMobile> {
  List<Contact>? _contacts;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final status = await Permission.contacts.request();
    if (status.isGranted) {
      _fetchContacts();
    } else {}
  }

  Future<void> _fetchContacts() async {
    final contacts = await FastContacts.getAllContacts();

    setState(() {
      _contacts = contacts;
    });
    print(contacts);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Contacts')),
        body: _body(),
      );

  Widget _body() {
    if (_contacts == null) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: _contacts!.length,
      itemBuilder: (context, i) => ListTile(
        title: Text(_contacts![i].displayName),

        // Add more contact details or actions here if needed.
      ),
    );
  }
}

//MediaQuery.sizeOf(context).height;


// void saveEmergencyContacts(List<Contact> _selectedContacts) async {
  //   final _pref = await SharedPreferences.getInstance();

  //   final _contacts = _selectedContacts.map((e) {
  //     final contactMap = {
  //       'id': e.id,
  //       'phones': e.phones
  //           .map((phone) => {
  //                 'number': phone.number,
  //                 'label': phone.label,
  //               })
  //           .toList(),
  //       'emails': e.emails
  //           .map((email) => {
  //                 'address': email.address,
  //                 'label': email.label,
  //               })
  //           .toList(),
  //       'structuredName': e.structuredName != null
  //           ? {
  //               'displayName': e.structuredName!.displayName,
  //               'namePrefix': e.structuredName!.namePrefix,
  //               'givenName': e.structuredName!.givenName,
  //               'middleName': e.structuredName!.middleName,
  //               'familyName': e.structuredName!.familyName,
  //               'nameSuffix': e.structuredName!.nameSuffix,
  //             }
  //           : null,
  //       'organization': e.organization != null
  //           ? {
  //               'company': e.organization!.company,
  //               'department': e.organization!.department,
  //               'jobDescription': e.organization!.jobDescription,
  //             }
  //           : null,
  //     };
  //     return json.encode(contactMap);
  //   }).toList();

  //   _pref.setStringList('emergency', _contacts);

  //   notifyListeners();
  // }




  // Future<List<Contact>> fetchSavedEmergency() async {
  //   final contacts = <Contact>[];
  //   final pref = await SharedPreferences.getInstance();

  //   if (pref.containsKey('emergency')) {
  //     final data = pref.getStringList('emergency') ?? [];
  //     print('hello');

  //     data.forEach((contactJson) {
  //       final contactMap = json.decode(contactJson);
  //       final contact = Contact.fromMap({
  //         'id': contactMap['id'],
  //         'phones': (contactMap['phones'] as List<Map<String, dynamic>>)
  //             .map((phoneMap) => Phone.fromMap(phoneMap))
  //             .toList(),
  //         'emails': (contactMap['emails'] as List<Map<String, dynamic>>)
  //             .map((emailMap) => Email.fromMap(emailMap))
  //             .toList(),
  //         'structuredName': contactMap['structuredName'] != null
  //             ? StructuredName.fromMap(contactMap['structuredName'])
  //             : null,
  //         'organization': contactMap['organization'] != null
  //             ? Organization.fromMap(contactMap['organization'])
  //             : null,
  //       });
  //       contacts.add(contact);
  //       print('hello');
  //     });
  //   }

  //   return contacts;
  // }