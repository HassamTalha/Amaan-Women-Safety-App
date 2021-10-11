import 'package:flutter/material.dart';

class PharmacyCard extends StatelessWidget {
    final Function openMapFunc;

  const PharmacyCard({Key key, this.openMapFunc}) : super(key: key);

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
                openMapFunc("Pharmacies near me");
              },
              child: Container(
                  height: 50,
                  width: 50,
                  child: Center(
                      child: Image.asset(
                    "assets/pharmacy.png",
                    height: 32,
                  ))),
            ),
          ),
          Text("Pharmacies")
        ],
      ),
    );
  }
}
