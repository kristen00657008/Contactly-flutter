import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'LoginPage.dart';
import 'helpers/Constants.dart';

void main() => runApp(ContactlyApp());

class ContactlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final routes = <String, WidgetBuilder> {
      loginPageTag: (context) => LoginPage(),
      homePageTag: (context) => HomePage(),
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: new ThemeData(
        primaryColor: appDarkGreyColor,
      ),
      home: LoginPage(),
      routes: routes,
    );
  }


}