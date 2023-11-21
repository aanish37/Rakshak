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



  //code for pinput

  
                //  Pinput(
                //   controller: pinController,
                //   focusNode: focusNode,
                //   defaultPinTheme: defaultPinTheme,
                //   separator: const SizedBox(width: 8),
                //   validator: (value) {
                //     if (widget.userPin == -1111) {
                //       print('try to add pin');
                //       return null;
                //     } else if (value == null) {
                //       return 'Add Pin First';
                //     } else if (int.parse(value) == widget.userPin) {
                //       return null;
                //     } else {
                //       print('Pin is incorrect');
                //       return 'Pin is incorrect';
                //     }
                //   },
                //   onClipboardFound: (value) {
                //     debugPrint('onClipboardFound: $value');
                //     pinController.setText(value);
                //   },
                //   hapticFeedbackType: HapticFeedbackType.lightImpact,
                //   onCompleted: (pin) async {
                //     if (widget.userPin == -1111) {
                //       print('try to add pin');
                //       Provider.of<EmergencyContacts>(context, listen: false)
                //           .createPin(pin);

                //       Navigator.pop(context);
                //     } else {
                //       if (int.parse(pin) == widget.userPin) {
                //         print('password matched as above start sending messages');

                //         if (widget.alerted) {
                //           print(false);
                //           Provider.of<EmergencyContacts>(context, listen: false)
                //               .setAlertedStatus(false);
                //         }

                //         if (widget.alerted == false) {
                //           print(true);
                //           final numbers = await Provider.of<EmergencyContacts>(
                //                   context,
                //                   listen: false)
                //               .checkForContacts();

                //           Provider.of<EmergencyContacts>(context, listen: false)
                //               .setAlertedStatus(true);
                //           //start sending message;]

                //           if (numbers == []) {
                //             print('add numbers first');
                //           } else {
                //             print('numbers added');
                //             print(numbers);

                //             requestSmsPermission('-1111','I am in Danger, Please find me here!!!');
                //             // numbers.map((number) {
                //             //   final msg=number.split('***')[1];

                //             //   requestSmsPermission(msg);
                //             // });
                //             print('executed');
                //           }
                //         }

                //         Navigator.pop(context);
                //       } else {
                //         print('Pin is incorrect');
                //       }
                //     }
                //     debugPrint('onCompleted: $pin');
                //   },
                //   cursor: Column(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Container(
                //         margin: const EdgeInsets.only(bottom: 9),
                //         width: 22,
                //         height: 1,
                //         color: focusedBorderColor,
                //       ),
                //     ],
                //   ),
                //   focusedPinTheme: defaultPinTheme.copyWith(
                //     decoration: defaultPinTheme.decoration!.copyWith(
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(color: focusedBorderColor),
                //     ),
                //   ),
                //   submittedPinTheme: defaultPinTheme.copyWith(
                //     decoration: defaultPinTheme.decoration!.copyWith(
                //       color: fillColor,
                //       borderRadius: BorderRadius.circular(19),
                //       border: Border.all(color: focusedBorderColor),
                //     ),
                //   ),
                //   errorPinTheme: defaultPinTheme.copyBorderWith(
                //     border: Border.all(color: Colors.redAccent),
                //   ),
                // ),
