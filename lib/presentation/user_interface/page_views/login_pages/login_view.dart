
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huawei_account/huawei_account.dart';
import 'package:remainder_application/presentation/user_interface/page_views/dashboard.dart';
import 'package:remainder_application/presentation/user_interface/widgets/button.dart';


class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<String> _logs = [];

  late AuthAccount _account;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("",
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                child: Column(
                  children: [
                    HuaweiIdAuthButton(
                        onPressed: _signIn,
                        elevation: 0,
                        borderRadius: AuthButtonRadius.SMALL,
                        buttonColor: AuthButtonBackground.RED),
                    authButton("SILENT SIGN IN", _silentSignIn),
                    authButton("SIGN OUT", _signOut),
                    authButton("CANCEL AUTHORIZATION", _revokeAuthorization),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                        child: ElevatedBtn(onPressed:() { Get.to(() => const Dashboard());}, label: "Continue to Application"))
                  ],
                ),
              ),
              Divider(indent: 15, endIndent: 15, color: Colors.blueGrey),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text("---- DOUBLE TAP TO CLEAR LOGS ----"),
              ),
              Expanded(
                  child: GestureDetector(
                    onDoubleTap: () {
                      setState(() {
                        _logs.clear();
                      });
                    },
                    child: Container(
                      child: ListView.builder(
                        itemCount: _logs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(_logs[index],
                                style: TextStyle(color: Colors.black54)),
                          );
                        },
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }

  _signIn() async {
    final helper = AccountAuthParamsHelper();
    helper
      ..setProfile()
      ..setAccessToken();

    try {
      _account = await AccountAuthService.signIn(helper);
      _addToLogs("FROM SIGN IN: " + _account.toMap().toString());
    } on Exception catch (e) {
      _addToLogs(e.toString());
    }
  }

  _signOut() async {
    try {
      final bool res = await AccountAuthService.signOut();
      _addToLogs("FROM SIGN OUT: $res");
    } on Exception catch (e) {
      _addToLogs(e.toString());
    }
  }

  _silentSignIn() async {
    try {
      final AuthAccount account = await AccountAuthService.silentSignIn();
      _addToLogs("FROM SILENT SIGN IN: " + account.displayName!);
    } on Exception catch (e) {
      _addToLogs(e.toString());
    }
  }

  _revokeAuthorization() async {
    try {
      final bool res = await AccountAuthService.cancelAuthorization();
      _addToLogs("FROM CANCEL AUTHORIZATION: $res");
    } on Exception catch (e) {
      _addToLogs(e.toString());
    }
  }

  _addToLogs(String s) {
    setState(() {
      _logs.add(s);
    });
  }
}

Widget authButton(String text, VoidCallback callback) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.zero,
    margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(8)),
    child: ElevatedButton(
        onPressed: callback,
        child: Text(text.toUpperCase()),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
        )),
  );
}