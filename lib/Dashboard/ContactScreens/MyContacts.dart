import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyContactsScreen extends StatefulWidget {
  const MyContactsScreen({Key key}) : super(key: key);

  @override
  _MyContactsScreenState createState() => _MyContactsScreenState();
}

class _MyContactsScreenState extends State<MyContactsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFCFE),
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "SOS Contacts",
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.w900, color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Image.asset("assets/phone_red.png"),
            onPressed: () {},
          )),
      body: FutureBuilder(
          future: checkforContacts(),
          builder: (context, AsyncSnapshot<List<String>> snap) {
            if (snap.hasData && snap.data.isNotEmpty) {
              return ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            backgroundImage: AssetImage("assets/user.png"),
                          ),
                          title: Text(
                              snap.data[index].split("***")[0] ?? "No Name"),
                          subtitle: Text(
                              snap.data[index].split("***")[1] ?? "No Contact"),
                        ),
                      ),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            print('Delete');
                          },
                        ),
                      ],
                    );
                    // return Card(
                    //     child: ListTile(
                    //   leading: CircleAvatar(
                    //     backgroundColor: Colors.grey[200],
                    //     backgroundImage: AssetImage("assets/user.png"),
                    //   ),
                    //   title: Text("Hassam Talha"),
                    //   subtitle: Text(snap.data[index]),
                    // ));
                  });
            } else {
              return Center(
                child: Text("No Contacts found!"),
              );
            }
          }),
    );
  }

  Future<List<String>> checkforContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> contacts = prefs.getStringList("numbers") ?? [];
    print(contacts);
    return contacts;
  }
}
