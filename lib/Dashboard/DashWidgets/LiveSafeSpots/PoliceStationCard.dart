import 'package:flutter/material.dart';

class PoliceStationCard extends StatelessWidget {
  final Function openMapFunc;
  const PoliceStationCard({Key key, this.openMapFunc}) : super(key: key);

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
              onTap: (){
                openMapFunc("Police Stations near me");
              },
              child: Container(
                  height: 50,
                  width: 50,
                  child: Center(
                      child: Image.asset(
                    "assets/police-badge.png",
                    height: 32,
                  ))),
            ),
          ),
          Text("Police Stations")
        ],
      ),
    );
  }
}
