import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/widgets/eventsWidgets/actionButtions.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'datePicker.dart';
import '../../../services/eventServices/formService.dart';

class RegularEventsPage extends StatefulWidget {
  final String title;

  RegularEventsPage({Key key, this.title}) : super(key: key);
  @override
  RegularEventsPageState createState() => RegularEventsPageState();
}

class RegularEventsPageState extends State<RegularEventsPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _fromKey;
  SharedPreferences _preferences;
  TextEditingController _eventAddress, _eventName, _eventDesc;
  DateTime _selectedDateFrom, _selectedDateTo;
  @override
  void initState() {
    super.initState();
    _fromKey = GlobalKey();
    _eventName = TextEditingController();
    _eventAddress = TextEditingController();
    _eventDesc = TextEditingController();
    _selectedDateFrom = DateTime.now();
    _selectedDateTo = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _textSection(),
          ],
        ),
      ),
    );
  }

  void _clearValues() {
    _eventName.text = '';
    _eventAddress.text = '';
    _eventDesc.text = '';
    _selectedDateFrom = DateTime.now();
    _selectedDateTo = DateTime.now();
  }

  void _updateField() async {
    _preferences = await SharedPreferences.getInstance();
    FormService.regularEvent(
            _preferences.getString('user_email'),
            _eventName.text,
            _eventAddress.text,
            _eventDesc.text,
            DateFormat.yMMMd().format(_selectedDateFrom),
            DateFormat.yMMMd().format(_selectedDateTo))
        .then((result) {
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

  Form _textSection() {
    return Form(
        key: _fromKey,
        child: Container(
          color: Color(0xffFFFFFF),
          child: Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                          validator: (value) =>
                              value.isEmpty ? 'Event Name is required!' : null,
                        ),
                      ),
                    ],
                  ),
                ),
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
                            controller: _eventAddress,
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
                            validator: (value) => value.isEmpty
                                ? 'Event Address is required!'
                                : null,
                          ),
                        ),
                      ],
                    )),
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
                              'Locate on Map',
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
                              'Event Date *',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 50.0, right: 25.0, top: 2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      DatePicker(
                        labelText: 'From',
                        selectedDate: _selectedDateFrom,
                        selectDate: (DateTime value) =>
                            setState(() => _selectedDateFrom = value),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50.0, right: 25.0, top: 9.0),
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    DatePicker(
                      labelText: 'To',
                      selectedDate: _selectedDateTo,
                      selectDate: (value) =>
                          setState(() => _selectedDateTo = value),
                    )
                  ]),
                ),
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
                          controller: _eventDesc,
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
                          validator: (value) =>
                              value.isEmpty ? 'Description is required!' : null,
                        )),
                      ],
                    )),
                ActionButtons(
                    onSave: () {
                      if (_fromKey.currentState.validate()) {
                        if (_selectedDateTo
                                .difference(_selectedDateFrom)
                                .inDays >=
                            0) {
                          _updateField();
                        } else {
                          _showDialog(context, 'Please enter valid dates!');
                        }
                      }
                    },
                    onCancel: () => _clearValues())
              ],
            ),
          ),
        ));
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
