import 'package:flutter/material.dart';

class BusStationCard extends StatelessWidget {
    final Function openMapFunc;

  const BusStationCard({Key key, this.openMapFunc}) : super(key: key);

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
                openMapFunc("Bus stops near me");
              },
              child: Container(
                  height: 50,
                  width: 50,
                  child: Center(
                      child: Image.asset(
                    "assets/bus-stop.png",
                    height: 32,
                  ))),
            ),
          ),
          Text("Bus Stations")
        ],
      ),
    );
  }
}
