import 'package:contactly/helpers/Constants.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final logo = CircleAvatar(
      backgroundColor: Colors.black,
      radius: bigRadius,
      child: appLogo,
    );

    final pinCode = TextFormField(
      controller: _pinCodeController,
      keyboardType: TextInputType.phone,
      maxLength: 4,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: pinCodeHintText,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.8),
        )
      ),
      style: TextStyle(
        color: Colors.white
      ),
      autofocus: true,
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          primary: Colors.black26
        ),
        onPressed: () {
          if(_pinCodeController.text.length != 4) {
            showAlertDialog(context);
          }else{
            Navigator.of(context).pushNamed(homePageTag);
          }
        },
        child: Text(loginButtonText, style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: appDarkGreyColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,   //let list scrollable
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: bigRadius),
            pinCode,
            SizedBox(height: buttonHeight),
            loginButton,
          ],
        ),
      ),
    );
  }
}

// Show AlertDialog
Future<void> showAlertDialog(BuildContext context) async{
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text("AlertDialog component"),
    actions: [
      TextButton(
        child: Text("Thanks!"),
        onPressed: () {
          Navigator.of(context).pop();
        }
      ),
      ElevatedButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.red,
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          )
        ),
      ),
      OutlinedButton(
          child: Text("Cancel"),
          style: OutlinedButton.styleFrom(
            primary: Colors.purple,
            side: BorderSide(width: 2, color: Colors.amber),
            elevation: 0.1
          ),
          onPressed: () {
            Navigator.pop(context);
          }
      ),
      IconButton(
        icon: Icon(Icons.star),
        iconSize: 50,
        splashRadius: 10,
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );

  // Show the dialog
  showDialog(
      context: context,
      barrierDismissible: false,  // user must tap button!
      builder: (BuildContext context) {
        return dialog;
      }
  );
}
