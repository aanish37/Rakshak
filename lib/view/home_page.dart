import 'package:flutter/material.dart';
import '../constant.dart';
import '../widget/pinBottomSheet.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  int index = 0;

  HomePage({this.index = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  bool alerted = false;
  int pin = -1111;

  @override
  void initState() {
    // TODO: implement initS
    // tate
    super.initState();

    if (widget.index == 1) {
      currentPage = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFAFCFE),
        floatingActionButton: currentPage == 1
            ? FloatingActionButton(
                // backgroundColor: backgroundColor,
                onPressed: () {
                  Navigator.pushNamed(context, '/phone');
                },
                backgroundColor: Colors.white,

                // child: Icon(
                //   Icons.add_call,
                //   color: Colors.white,
                // ),
                child: Icon(
                  Icons.person_add_alt_1_rounded,
                  color: backgroundColor,
                  size: 36,
                ),
              )
            : FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {},
                child: alerted
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/alert.png",
                            height: 35,
                          ),
                          Text("STOP")
                        ],
                      )
                    : Image.asset(
                        "assets/icons/alert.png",
                        height: 80,
                      ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  if (currentPage != 0)
                    setState(() {
                      currentPage = 0;
                    });
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
                  if (currentPage != 1)
                    setState(() {
                      currentPage = 1;
                    });
                },
                child: Image.asset("assets/phone.png", height: 28),
              ),
            ],
          ),
        ),
        body: pages[currentPage]);
  }
}
