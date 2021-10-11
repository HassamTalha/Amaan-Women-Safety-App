import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePinScreen extends StatefulWidget {
  const ChangePinScreen({Key key}) : super(key: key);

  @override
  _ChangePinScreenState createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  bool pinChanged = false;
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFCFE),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.pop(context);
            }),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "Change PIN",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
            ),
          ),
          Center(
            child: Image.asset(
              "assets/pin.png",
              height: 70,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(20.0),
            child: PinPut(
              onSaved: (value) {
                print(value);
              },
              fieldsCount: 4,
              onSubmit: (String pin) => _showSnackBar(pin, context),
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(20.0),
              ),
              selectedFieldDecoration: _pinPutDecoration,
              followingFieldDecoration: _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: Colors.deepPurpleAccent.withOpacity(.5),
                ),
              ),
            ),
          ),
          SizedBox(height: 100),
          Visibility(
              visible: pinChanged,
              child: Center(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 60,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Center(
                          child: Text(
                        "Done",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 10),
      content: Container(
        height: 20.0,
        child: Center(
          child: Text(
            'Pin Changed. Value: $pin',
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    changePin(int.parse(pin));
    setState(() {
      pinChanged = true;
    });
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void changePin(int parse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("pin", parse);
  }
}
