import 'package:flutter/material.dart';
import 'package:rakhshak/widget/Emergency.dart';
import '../widget/location_widget.dart';
import '../widget/safe_home.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Emergency Contacts',
                  style: Theme.of(context)
                      .copyWith()
                      .primaryTextTheme
                      .headlineLarge,
                ),
              ),
              TextButton(onPressed: () {}, child: Text('See More')),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Emergency(
                  title: 'Nepal Police',
                  number: '100',
                  image: 'assets/nepal_police.png',
                  description: "In case of any emergency call",
                ),
                Emergency(
                  title: 'Ambulance',
                  number: '102',
                  image: 'assets/nepal_ambulance.png',
                  description: "In case of any medical emergency call",
                ),
                Emergency(
                  title: 'Fire Brigade',
                  number: '101',
                  image: 'assets/fire_brigade.png',
                  description: "In case of any fire emergency call",
                ),
                Emergency(
                  title: 'CIAA',
                  number: '107',
                  image: 'assets/ciaa.png',
                  description: 'In case of corruption call',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Location Services',
                  style: Theme.of(context)
                      .copyWith()
                      .primaryTextTheme
                      .headlineLarge,
                ),
              ),
              TextButton(onPressed: () {}, child: Text('See More')),
            ],
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  LocationWidget(
                      title: 'Police Station',
                      image: 'assets/police_station.png'),
                  LocationWidget(
                      title: 'Hospital', image: 'assets/hospital.png'),
                  LocationWidget(
                      title: 'Pharmacy', image: 'assets/pharmacy.png'),
                  LocationWidget(
                      title: 'Bus Stations', image: 'assets/bus_stop.png'),
                ],
              )),
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.all(10),
            height: 200,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SafeHome(),
          )
        ],
      ),
    );
  }
}
