import 'package:flutter/material.dart';
import 'package:rakhshak/constant.dart';

import 'package:url_launcher/url_launcher.dart';

class Emergency extends StatelessWidget {
  const Emergency(
      {super.key,
      required this.title,
      required this.number,
      required this.image,
      required this.description});
  final String title;
  final String number;
  final String image;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () {
            _callNumber(number);
          },
          child: Container(
            height: 180,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  backgroundColor,
                  backgroundColor,
                  Color.fromARGB(255, 191, 191, 247),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.5),
                      radius: 25,
                      child: Center(
                          child: Image.asset(
                        image,
                        height: 35,
                      ))),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.06),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(300)),
                        child: Center(
                          child: Text(
                            number,
                            style: TextStyle(
                                color: backgroundColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _callNumber(String number) async {
    try {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: number,
      );

      if (await canLaunch(launchUri.toString())) {
        await launch(launchUri.toString());
      } else {
        print('Cannot launch URL');
      }
    } catch (e) {
      print(e);
    }
  }
}
