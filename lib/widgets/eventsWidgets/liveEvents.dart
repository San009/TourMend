import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'actionButtions.dart';
import '../../services/eventServices/formService.dart';

class LiveEventsPage extends StatefulWidget {
  final String title;

  LiveEventsPage({Key key, this.title}) : super(key: key);
  @override
  LiveEventsPageState createState() => LiveEventsPageState();
}

class Events {
  int id;
  String name;

  Events(this.id, this.name);

  static List<Events> getEvents() {
    return <Events>[
      Events(1, 'Landslide'),
      Events(2, 'Under construction'),
      Events(3, 'Flood'),
      Events(4, 'Traffic Jam'),
      Events(5, 'VIP escorting'),
      Events(6, 'Other')
    ];
  }
}

class LiveEventsPageState extends State<LiveEventsPage>
    with SingleTickerProviderStateMixin {
  TextEditingController _address;
  TextEditingController _description;
  TextEditingController _eventName;
  SharedPreferences _preferences;
  GlobalKey<FormState> _formKey;
  List<Events> _events = Events.getEvents();
  List<DropdownMenuItem<Events>> _dropdownMenuItems;
  Events _selectedEvent;

  @override
  void initState() {
    _address = TextEditingController();
    _description = TextEditingController();
    _eventName = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _dropdownMenuItems = buildDropdownMenuItems();
    _selectedEvent = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Events>> buildDropdownMenuItems() {
    List<DropdownMenuItem<Events>> items = List();
    for (Events event in _events) {
      items.add(
        DropdownMenuItem(
          value: event,
          child: Text(
            event.name,
          ),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Events selectedEvent) {
    setState(() {
      _selectedEvent = selectedEvent;
    });
  }

  void _clearValues() {
    _address.text = '';
    _description.text = '';
  }

  void _updatefield() async {
    _preferences = await SharedPreferences.getInstance();
    if (_selectedEvent.name != 'Other') _eventName.text = 'none';
    FormService.liveEvent(
      _preferences.getString('user_email'),
      _address.text,
      _description.text,
      _selectedEvent.name,
      _eventName.text,
    ).then((result) {
      print(result);
      if (result == '1') {
        _clearValues();
        _showDialog(context,
            'Pending Approval!\nYou will notified after being approved.');
      } else if (result == '0') {
        // _clearValues();
        _showDialog(context, 'Error while submitting event!');
      } else {
        _showDialog(context, 'Error in method!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            textSection(),
          ],
        ),
      ),
    );
  }

  Form textSection() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(bottom: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Live events Type',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 9.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      height: 35,
                      width: 325,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: DropdownButton(
                                value: _selectedEvent,
                                items: _dropdownMenuItems,
                                onChanged: (value) =>
                                    onChangeDropdownItem(value),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            _selectedEvent.name == 'Other'
                ? Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Event Name *',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 9.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
                                controller: _eventName,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  hintText: 'Event Name',
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(5.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                validator: (value) => value.isEmpty
                                    ? 'Event Name is required!'
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Event Address *',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 9.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        controller: _address,
                        validator: (value) =>
                            value.isEmpty ? 'Address is required!' : null,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          hintText: 'Enter Address',
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Locate on Map *',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 9.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: 325,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: Image.asset(
                        'assets/places/coming.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Description *',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 9.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Flexible(
                        child: TextFormField(
                      controller: _description,
                      validator: (value) =>
                          value.isEmpty ? 'Description is required!' : null,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintText: 'Write here',
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(5.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    )),
                  ],
                )),
            ActionButtons(
              onSave: () {
                if (_formKey.currentState.validate()) {
                  _updatefield();
                }
              },
              onCancel: () => _clearValues(),
            )
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
