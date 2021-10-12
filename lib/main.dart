import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:womensafteyhackfair/Dashboard/Splsah/Splash.dart';
import 'package:vibration/vibration.dart';
import 'package:background_location/background_location.dart';
import 'package:workmanager/workmanager.dart';
import 'package:telephony/telephony.dart';

backgrounMessageHandler(SmsMessage message) async {
  // Handle background message
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterBackgroundService.initialize(onStart);
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  runApp(MyApp());
}

const simplePeriodicTask = "simplePeriodicTask";

void onStart() async {
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  service.onDataReceived.listen((event) async {
    if (event["action"] == "setAsForeground") {
      service.setForegroundMode(true);

      return;
    }

    if (event["action"] == "setAsBackground") {
      service.setForegroundMode(false);
    }

    if (event["action"] == "stopService") {
      service.stopBackgroundService();
    }
  });
  Location _location;

  await BackgroundLocation.setAndroidNotification(
    title: "Location tracking is running in the background!",
    message: "You can turn it off from settings menu inside the app",
    icon: '@mipmap/ic_logo',
  );
  BackgroundLocation.startLocationService(
    distanceFilter: 20,
  );

  BackgroundLocation.getLocationUpdates((location) {
    _location = location;
    prefs.setStringList("location",
        [location.latitude.toString(), location.longitude.toString()]);
  });
  String screenShake = "Be strong, We are with you!";
  ShakeDetector.autoStart(
      shakeThresholdGravity: 7,
      onPhoneShake: () async {
        print("Test 1");
        if (await Vibration.hasVibrator()) {
          print("Test 2");
          if (await Vibration.hasCustomVibrationsSupport()) {
            print("Test 3");
            Vibration.vibrate(duration: 1000);
          } else {
            print("Test 4");
            Vibration.vibrate();
            await Future.delayed(Duration(milliseconds: 500));
            Vibration.vibrate();
          }
          print("Test 5");
        }
        print("Test 6");
        String link = '';
        print("Test 7");
        try {
          double lat = _location.latitude;
          double long = _location.longitude;
          print("$lat ... $long");
          print("Test 9");
          link = "http://maps.google.com/?q=$lat,$long";
          SharedPreferences prefs = await SharedPreferences.getInstance();
          List<String> numbers = prefs.getStringList("numbers") ?? [];
          String error;
          try {
            if (numbers.isEmpty) {
              screenShake = "No contacs found, Please call 15 ASAP.";
              debugPrint(
                'No Contacts Found!',
              );
              return;
            } else {
              for (int i = 0; i < numbers.length; i++) {
                Telephony.backgroundInstance.sendSms(
                    to: numbers[i], message: "Help Me! Track me here.\n$link");
              }
              prefs.setBool("alerted", true);
              screenShake = "SOS alert Sent! Help is on the way.";
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
          }
          print("Test 10");
          print(link);
        } catch (e) {
          print("Test 11");
          print(e);
        }
      });
  print("Test 12");
  // bring to foreground
  service.setForegroundMode(true);
  Timer.periodic(Duration(seconds: 1), (timer) async {
    if (!(await service.isServiceRunning())) timer.cancel();

    service.setNotificationInfo(
      title: "Safe Shake activated!",
      content: screenShake,
    );

    service.sendData(
      {"current_date": DateTime.now().toIso8601String()},
    );
  });
}

//GET HOME SAFE _ WORK MANAGER SET TO 15 minutes frequency

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    String contact = inputData['contact'];
    final prefs = await SharedPreferences.getInstance();
    print(contact);
    List<String> location = prefs.getStringList("location");
    String link = "http://maps.google.com/?q=${location[0]},${location[1]}";
    print(location);
    print(link);
    Telephony.backgroundInstance
        .sendSms(to: contact, message: "I am on my way! Track me here.\n$link");
    return true;
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hackfair 2.0 - GDSC - CUI',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}
