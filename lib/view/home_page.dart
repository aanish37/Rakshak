import 'package:flutter/material.dart';
import '../constant.dart';
import '../widget/pinBottomSheet.dart';
import 'package:provider/provider.dart';
import '../model/emergency_contacts.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  int index = 0;

  HomePage({super.key, this.index = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  late bool alerted = false; // Initialize with a default value
  List<String> numbers = [];

  @override
  void initState() {
    super.initState();
    if (widget.index == 1) {
      currentPage = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    //   final userPin =
    // //       Provider.of<EmergencyContacts>(context, listen: false).getPin();
    //   final alerted = Provider.of<EmergencyContacts>(context, listen: false)
    //       .getAlertedStatus();

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          height: 20,
          margin: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            // color: backgroundLight,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/logo_transparent.png',
            fit: BoxFit.contain,
          ),
        ),
        title: Text('Rakshak'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.settings,
              size: 30,
              color: Colors.black,
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xFFFAFCFE),
      floatingActionButton: currentPage == 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/phone');
              },
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.person_add_alt_1_rounded,
                color: backgroundColor,
                size: 36,
              ),
            )
          : FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                setState(() {
                  showPinModelBottomSheet(context);
                });
              },
              child: FutureBuilder(
                  future: Provider.of<EmergencyContacts>(context, listen: true)
                      .getAlertedStatus(),
                  builder: ((context, snapshot) {
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      return snapshot.data == true
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/alert.png",
                                  height: 35,
                                ),
                                const Text("STOP")
                              ],
                            )
                          : Image.asset(
                              "assets/icons/alert.png",
                              height: 80,
                            );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                if (currentPage != 0) {
                  setState(() {
                    currentPage = 0;
                  });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    "assets/home.png",
                    height: 28,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (currentPage != 1) {
                  setState(() {
                    currentPage = 1;
                  });
                }
              },
              child: Image.asset("assets/phone.png", height: 28),
            ),
          ],
        ),
      ),
      body: pages[currentPage],
    );
  }
}
