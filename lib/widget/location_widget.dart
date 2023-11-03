import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key, required this.title, required this.image});

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () {
                openMapFunc(title + " near me");
              },
              child: Container(
                  height: 80,
                  width: 80,
                  child: Center(
                      child: Image.asset(
                    image,
                    height: 50,
                  ))),
            ),
          ),
          Text(title)
        ],
      ),
    );
  }

  openMapFunc(String s) {
    MapsLauncher.launchQuery(s);
  }
}
