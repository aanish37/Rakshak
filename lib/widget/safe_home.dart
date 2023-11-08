import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:provider/provider.dart';
import './contact_item.dart';
import '../model/emergency_contacts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/sms.dart';
import 'dart:async';

class SafeHome extends StatefulWidget {
  const SafeHome({
    super.key,
  });

  @override
  State<SafeHome> createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
  bool getHomeSafeActivated = false;

  checkGetHomeActivated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      getHomeSafeActivated = prefs.getBool("getHomeSafe") ?? false;
    });
  }

  removeGetHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('getHomeSafe', false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    removeGetHome();
  }

  @override
  void initState() {
    super.initState();

    checkGetHomeActivated();
  }

  @override
  Widget build(BuildContext context) {
    checkGetHomeActivated();

    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () => showModalBottomSheet(
          context: context,
          builder: (context) =>
              SafeHomeWidget(getHomeActivated: getHomeSafeActivated),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Get Home Safe',
                      style: Theme.of(context)
                          .copyWith()
                          .primaryTextTheme
                          .bodyLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Share Location\n Periodically',
                      style: Theme.of(context)
                          .copyWith()
                          .primaryTextTheme
                          .bodySmall,
                      softWrap: true,
                    ),
                  ],
                ),
                Image.asset(
                  'assets/girl.png',
                  height: 120,
                ),
              ],
            ),
          ),
          Visibility(
            visible: getHomeSafeActivated,
            child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    SpinKitDoubleBounce(
                      color: Colors.red,
                      size: 15,
                    ),
                    Text("Currently Running...",
                        style: TextStyle(color: Colors.red, fontSize: 10)),
                  ],
                )),
          ),
        ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class SafeHomeWidget extends StatefulWidget {
  SafeHomeWidget({super.key, required this.getHomeActivated});
  bool getHomeActivated;
  @override
  State<SafeHomeWidget> createState() => _SafeHomeWidgetState();
}

class _SafeHomeWidgetState extends State<SafeHomeWidget> {
  changeStateOfHomeSafe(value, sharingNumber) async {
    print(value);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value == false) {
      widget.getHomeActivated = false;
      prefs.setBool("getHomeSafe", value);
    }

    if (sharingNumber != null && value == true) {
      setState(() {
        widget.getHomeActivated = true;
        prefs.setBool("getHomeSafe", value);
      });
    }
  }

  Timer? timer;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    String? sharingNumber =
        Provider.of<EmergencyContacts>(context, listen: true)
            .fetchSharingContact();
    return Container(
      padding: const EdgeInsets.all(12),
      height: 800,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Divider(
                  indent: 20,
                  endIndent: 20,
                ),
              ),
              Text(
                'Get Home Safe',
                style:
                    Theme.of(context).copyWith().primaryTextTheme.headlineLarge,
              ),
              const Expanded(
                child: Divider(
                  indent: 20,
                  endIndent: 20,
                ),
              ),
            ],
          ),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                    title: sharingNumber == null
                        ? const Text(
                            'Select One Contact First',
                            style: TextStyle(fontSize: 16),
                          )
                        : const Text(
                            'Share Location',
                            style: TextStyle(fontSize: 20),
                          ),
                    value: widget.getHomeActivated,
                    onChanged: (value) async {
                      print(value);
                      changeStateOfHomeSafe(value, sharingNumber);
                     


                      if (value == false) {
                        Provider.of<EmergencyContacts>(context, listen: false)
                            .saveSharingContacts(null);
                      }

                      if (sharingNumber != null && value == true) {
                        setState(() {
                          widget.getHomeActivated = true;
                        });

                        if (value == true) {
                   
                          requestSmsPermission(sharingNumber);
                        }
                      }

                      timer = Timer.periodic(Duration(minutes: 1), (timer) {
                        if (sharingNumber != null && value == true) {
                          requestSmsPermission(sharingNumber);
                        }
                      });

                      if (value == false) {
                        timer?.cancel();
                        print('stopeed');
                      }

                      //only toggle if sharing number is not null else do nothing
                    }),
                const ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Location'),
                  subtitle: Text('Kathmandu, Nepal'),
                ),
                const ListTile(
                  leading: Icon(Icons.timer),
                  title: Text('Repeat'),
                  subtitle: Text('1 Minutes'),
                ),
              ],
            ),
          ),
          const ContactItem(),
        ],
      ),
    );
  }
}
