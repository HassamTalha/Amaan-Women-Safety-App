import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_maintained/sms.dart';
import 'package:womensafteyhackfair/Dashboard/ContactScreens/phonebook_view.dart';
import 'package:womensafteyhackfair/Dashboard/Home.dart';
import 'package:womensafteyhackfair/Dashboard/ContactScreens/MyContacts.dart';

class Dashboard extends StatefulWidget {
  final int pageIndex;
  const Dashboard({Key key, this.pageIndex = 0}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState(currentPage: pageIndex);
}

class _DashboardState extends State<Dashboard> {
  _DashboardState({this.currentPage = 0});

  List<Widget> screens = [Home(), MyContactsScreen()];

  int currentPage = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFCFE),
      floatingActionButton: currentPage == 1
          ? FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PhoneBook()));
              },
              child: Image.asset(
                "assets/add-contact.png",
                height: 60,
              ),
            )
          : FloatingActionButton(
              backgroundColor: Color(0xFFFB9580),
              onPressed: sendAlertSMS,
              child: Image.asset(
                "assets/icons/alert.png",
                height: 36,
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    if (currentPage != 0)
                      setState(() {
                        currentPage = 0;
                      });
                  },
                  child: Image.asset(
                    "assets/home.png",
                    height: 28,
                  )),
              InkWell(
                  onTap: () {
                    if (currentPage != 1)
                      setState(() {
                        currentPage = 1;
                      });
                  },
                  child: Image.asset("assets/phone_red.png", height: 28)),
            ],
          ),
        ),
      ),
      body: SafeArea(child: screens[currentPage]),
    );
  }

  void sendSMS(String number, String msgText) {
    SmsMessage msg = new SmsMessage(number, msgText);
    final SmsSender sender = new SmsSender();
    msg.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sending) {
        return Fluttertoast.showToast(
          msg: 'Sending Alert...',
          backgroundColor: Colors.blue,
        );
      } else if (state == SmsMessageState.Sent) {
        return Fluttertoast.showToast(
          msg: 'Alert Sent Successfully!',
          backgroundColor: Colors.green,
        );
      } else if (state == SmsMessageState.Fail) {
        return Fluttertoast.showToast(
          msg: 'Failure! Check your credits & Network Signals!',
          backgroundColor: Colors.red,
        );
      } else {
        return Fluttertoast.showToast(
          msg: 'Failed to send SMS. Try Again!',
          backgroundColor: Colors.red,
        );
      }
    });
    sender.sendSms(msg);
  }

  sendAlertSMS() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> numbers = prefs.getStringList("numbers") ?? [];
    LocationData myLocation;
    String error;
    Location location = new Location();
    try {
      myLocation = await location.getLocation();
      var currentLocation = myLocation;

      if (numbers.isEmpty) {
        return Fluttertoast.showToast(
          msg: 'No Contacts Found!',
          backgroundColor: Colors.red,
        );
      } else {
        var coordinates =
            Coordinates(currentLocation.latitude, currentLocation.longitude);
        var addresses =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        String link =
            "http://maps.google.com/?q=${currentLocation.latitude},${currentLocation.longitude}";
        for (int i = 0; i < numbers.length; i++) {
          sendSMS(numbers[i], "Help Me!\n${first.addressLine}\n$link");
        }
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Please grant permission';
        print('Error due to Denied: $error');
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied- please enable it from app settings';
        print("Error due to not Asking: $error");
      }
      myLocation = null;
    }
  }
}
