import 'package:flutter/material.dart';

class AboutCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String desc;
  final String asset;
  final double sizeFactor;
  AboutCard(
      {Key key,
      this.asset,
      this.desc,
      this.subtitle,
      this.title,
      this.sizeFactor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / sizeFactor,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    ListTile(
                      title: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Text(subtitle),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        desc,
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              child: Center(
                  child: Image.asset(
                "assets/$asset.png",
                height: 70,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
