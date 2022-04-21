import 'dart:ui';

import 'package:flutter/material.dart';
import 'models/Record.dart';
import 'helpers/URLLauncher.dart';

class DetailPage extends StatelessWidget {
  final Record record;
  DetailPage({required this.record});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(record.name),
      ),
      body: ListView(
        children: <Widget>[
          Hero(
            tag: "avator_" + record.name,
            child: Image.network(
              record.photo
            ),
          ),
          GestureDetector(
            onTap: () {
              URLLauncher().launchURL(record.url);
            },
            child: Container(
              padding: EdgeInsets.all(32),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text("Name:" + record.name),
                        ),
                        Text(
                          "Address:" + record.address,
                          style: TextStyle(color: Colors.grey[500]),
                        )
                      ],
                    ),
                  ),
                  Icon( Icons.phone,
                    color: Colors.red[500],
                  ),
                  Text(record.contact)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}
