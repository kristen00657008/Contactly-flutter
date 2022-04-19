import 'dart:ui';

import 'package:contactly/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'models/Record.dart';
import 'models/RecordList.dart';
import 'models/RecordService.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() {
    return _HomePageState();
  }

}

class _HomePageState extends State<HomePage> {
  final TextEditingController _filter = new TextEditingController();

  RecordList _records = RecordList(records: []);
  RecordList _filteredRecords = new RecordList(records: []);

  String _searchText = "";

  Icon _searchIcon = new Icon(Icons.search);

  Widget _appBarTitle = new Text(appTitle);

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _records.records = [];
    _filteredRecords.records = [];
    _getRecords();
  }

  void _getRecords() async {
    RecordList records = await RecordService().loadRecords();
    setState(() {
      for(Record record in records.records) {
        this._records.records.add(record);
        this._filteredRecords.records.add(record);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          elevation: 0.1,
          backgroundColor: appGreyColor,
          centerTitle: true,
          title: _appBarTitle,
          leading: new IconButton(
            icon: _searchIcon,
            onPressed: () {
              _searchPressed();
            },
          )
      ),
      backgroundColor: appDarkGreyColor,
      body: _buildList(context),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: _buildBottomBar()
    );
  }

  Widget _buildList(BuildContext context) {
    if (!(_searchText.isEmpty)) {
      _filteredRecords.records = [];
      for (int i = 0; i < _records.records.length; i++) {
        if (_records.records[i].name.toLowerCase().contains(_searchText.toLowerCase())
            || _records.records[i].address.toLowerCase().contains(_searchText.toLowerCase())) {
          _filteredRecords.records.add(_records.records[i]);
        }
      }
    }

    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: this._filteredRecords.records.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, Record record) {
    return Card(
      key: ValueKey(record.name),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.white24))),
              child: Hero(
                  tag: "avatar_" + record.name,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(record.photo),
                  )
              )
          ),
          title: Text(
            record.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              new Flexible(
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: record.address,
                            style: TextStyle(color: Colors.white),

                          ),
                          maxLines: 3,
                          softWrap: true,
                        )
                      ]))
            ],
          ),
          trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {},
        ),
      ),
    );
  }

  _HomePageState() {
    _filter.addListener(() {
      print("listening");
      if(_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _resetRecords();
          print("Reset");
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _resetRecords() {
    this._filteredRecords.records = [];
    for (Record record in _records.records) {
      this._filteredRecords.records.add(record);
    }
  }

  Widget _buildBottomBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
        elevation: 0.1,
        backgroundColor: appGreyColor,
        centerTitle: true,
        title: _appBarTitle,
        leading: new IconButton(
          icon: _searchIcon,
          onPressed: () {
            _searchPressed();
          },
        )

    );
  }

  void _searchPressed() {
    setState(() {
      if(this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          style: new TextStyle(color: Colors.white),
          decoration: new InputDecoration(
            prefixIcon:  new Icon(Icons.search, color: Colors.white),
            fillColor: Colors.white,
            hintText: 'Search by name',
            hintStyle: TextStyle(color: Colors.white),
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text(appTitle);
        _filter.clear();
      }
    });
  }
}

