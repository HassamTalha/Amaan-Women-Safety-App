import 'package:flutter/material.dart';

class SafeHome extends StatelessWidget {
  const SafeHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        
                      ),

                      child: Row(children: [
                        Expanded(child: ListTile(

                          title: Text("Get Home Safe"),
                         subtitle: Text("Share Location Periodically"),
                        )),
                        ClipRRect(
                           borderRadius: BorderRadius.circular(20),
                          child: Image.asset("assets/route.jpg"))
                      ],),
                    ),
                  ),
                );
  }
}