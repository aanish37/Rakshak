// import 'package:pinput/pinput.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:flutter/material.dart';
import 'package:rakhshak/constant.dart';
import 'package:rakhshak/model/emergency_contacts.dart';
import 'package:rakhshak/model/sms.dart';

import 'package:provider/provider.dart';

showPinModelBottomSheet(
  context,
) async {
  int userPin =
      await Provider.of<EmergencyContacts>(context, listen: false).getPin();

  bool alerted = await Provider.of<EmergencyContacts>(context, listen: false)
      .getAlertedStatus();
  showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          indent: 20,
                          endIndent: 20,
                        ),
                      ),
                      Text(
                        userPin != -1111
                            ? "Please enter your PIN!"
                            : "Create your Pin!",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const Expanded(
                        child: Divider(
                          indent: 20,
                          endIndent: 20,
                        ),
                      ),
                    ],
                  ),
                  Image.asset("assets/pin.png"),
                  Container(
                      // margin: const EdgeInsets.all(20.0),
                      padding: const EdgeInsets.all(20.0),
                      child: PinputExample(userPin: userPin, alerted: alerted)),
                ],
              ),
            ),
          ),
        );
      });
}

void _showSnackBar(String pin, BuildContext context, int userPin) {
  if (userPin == int.parse(pin)) {
    print(
      'We are glad that you are safe',
    );

    //stop sending sms
  } else {
    print(
      'Wrong Pin! Please try again',
    );
  }
}

// ignore: must_be_immutable
class PinputExample extends StatefulWidget {
  PinputExample({Key? key, required this.userPin, required this.alerted})
      : super(key: key);

  int userPin;
  bool alerted;

  @override
  State<PinputExample> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputExample> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  // late bool alerted;

  // createPassword(String pin) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final int parsedPin = int.parse(pin);
  //   prefs.setInt('password', parsedPin);
  //   print('password created succesfully');
  // }

  // Future<void> changeAlertStatus(value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('alerted', value);
  // // }

  // Future<void> getAlertStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   alerted = prefs.getBool('alerted') ?? false;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const fillColor = Color.fromRGBO(243, 246, 249, 0);

    final defaultPinTheme = PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(19),
      fieldHeight: 56,
      fieldWidth: 56,
      activeFillColor: fillColor,
      inactiveFillColor: fillColor,
      selectedFillColor: fillColor,
      selectedColor: backgroundLight,
      inactiveColor: Colors.black,
      activeColor: fillColor,
    );

    /// Optionally you can use form to validate the Pinput
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            // Specify direction if desired
            textDirection: TextDirection.ltr,
            child:

                PinCodeTextField(
              blinkDuration: Duration(milliseconds: 300),
              appContext: context,
              pastedTextStyle: TextStyle(
                color: Colors.green.shade600,
                fontWeight: FontWeight.bold,
              ),
              length: 4,
              obscureText: true,
              obscuringCharacter: '*',
              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              validator: (value) {
                if (widget.userPin == -1111) {
                  print('try to add pin');
                  return null;
                } else if (value == null) {
                  return 'Add Pin First';
                } else if (int.parse(value) == widget.userPin) {
                  return null;
                } else {
                  print('Pin is incorrect');
                  return 'Pin is incorrect';
                }
              },
              pinTheme: defaultPinTheme,
              cursorColor: Colors.black,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              keyboardType: TextInputType.number,
              boxShadows: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
              onCompleted: (pin) async {
                if (widget.userPin == -1111) {
                  print('try to add pin');
                  Provider.of<EmergencyContacts>(context, listen: false)
                      .createPin(pin);

                  Navigator.pop(context);
                } else {
                  if (int.parse(pin) == widget.userPin) {
                    print('password matched as above start sending messages');

                    if (widget.alerted) {
                      print(false);
                      Provider.of<EmergencyContacts>(context, listen: false)
                          .setAlertedStatus(false);
                    }

                    if (widget.alerted == false) {
                      print(true);
                      final numbers = await Provider.of<EmergencyContacts>(
                              context,
                              listen: false)
                          .checkForContacts();

                      Provider.of<EmergencyContacts>(context, listen: false)
                          .setAlertedStatus(true);
                      //start sending message;]

                      if (numbers == []) {
                        print('add numbers first');
                      } else {
                        print('numbers added');
                        print(numbers);

                        requestSmsPermission(
                            '-1111', 'I am in Danger, Please find me here!!!');
                        // numbers.map((number) {
                        //   final msg=number.split('***')[1];

                        //   requestSmsPermission(msg);
                        // });
                        print('executed');
                      }
                    }

                    Navigator.pop(context);
                  } else {
                    print('Pin is incorrect');
                  }
                }
                debugPrint('onCompleted: $pin');
              },
              onTap: () {
                print("Pressed");
              },
            ),
          ),
          TextButton(
            onPressed: () {
              focusNode.unfocus();
              formKey.currentState!.validate();
            },
            child: const Text('Validate'),
          ),
        ],
      ),
    );
  }
}
