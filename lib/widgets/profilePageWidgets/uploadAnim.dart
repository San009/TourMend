import 'package:flutter/material.dart';
import 'progress_painter.dart';
import 'dart:ui';
import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/profileServices/profilePic.dart';

class CustomDemo extends StatefulWidget {
  final File image;
  CustomDemo(this.image);

  @override
  CustomDemoState createState() => CustomDemoState();
}

class CustomDemoState extends State<CustomDemo>
    with SingleTickerProviderStateMixin {
  //
  double _percentage;
  double _nextPercentage;
  Timer _timer;
  AnimationController _progressAnimationController;
  bool _progressDone;
  var tcVisibility = false;
  SharedPreferences preferences;
  String userEmail;

  //

  @override
  void initState() {
    super.initState();
    super.initState();
    _percentage = 0.0;
    _nextPercentage = 0.0;
    _timer = null;
    _progressDone = false;
    initAnimationController();
    _getUserEmail();
  }

  initAnimationController() {
    _progressAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..addListener(
        () {
          setState(() {
            _percentage = lerpDouble(_percentage, _nextPercentage,
                _progressAnimationController.value);
          });
        },
      );
  }

  start() {
    Timer.periodic(Duration(milliseconds: 10), handleTicker);
  }

  handleTicker(Timer timer) {
    _timer = timer;
    if (_nextPercentage < 100) {
      publishProgress();
    } else {
      timer.cancel();
      setState(() {
        _progressDone = true;
      });
    }
  }

  startProgress() {
    if (null != _timer && _timer.isActive) {
      _timer.cancel();
    }
    setState(() {
      _percentage = 0.0;
      _nextPercentage = 0.0;
      _progressDone = false;
      start();
    });
  }

  publishProgress() {
    setState(() {
      _percentage = _nextPercentage;
      _nextPercentage += 0.5;
      if (_nextPercentage > 100.0) {
        _percentage = 0.0;
        _nextPercentage = 0.0;
      }
      _progressAnimationController.forward(from: 0.0);
    });
  }

  getDoneImage() {
    setState(() {
      tcVisibility = true;
    });
    _upload();
    return Image.network(
      "http://10.0.2.2/TourMendWebServices/Images/checkmark.png",
      width: 50,
      height: 50,
    );
  }

  getProgressText() {
    return Text(
      _nextPercentage == 0 ? '' : '${_nextPercentage.toInt()}%',
      style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.w800, color: Colors.green),
    );
  }

  progressView() {
    return CustomPaint(
      child: Center(
        child: _progressDone ? getDoneImage() : getProgressText(),
      ),
      foregroundPainter: ProgressPainter(
          defaultCircleColor: Colors.amber,
          percentageCompletedCircleColor: Colors.green,
          completedPercentage: _percentage,
          circleWidth: 50.0),
    );
  }

  _getUserEmail() async {
    preferences = await SharedPreferences.getInstance();
    userEmail = preferences.getString('user_email');
  }

  void _upload() async {
    try {
      GetUserInfo.uploadImage(
        widget.image,
        userEmail,
      );
    } catch (e) {
      Visibility(
        visible: tcVisibility,
        child: Text(
          " Error While Uploading ",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.green),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
      contentPadding: EdgeInsets.only(top: 10),
      elevation: 20.0,
      children: <Widget>[
        Container(
          height: 150.0,
          width: 150.0,
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.all(30.0),
          child: progressView(),
        ),
        Visibility(
          visible: tcVisibility,
          child: Text(
            " Uploaded successfully",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.green),
          ),
        ),
        Row(children: <Widget>[
          Expanded(
            child: RaisedButton(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Text(
                    'Upload',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Icon(
                    Icons.file_upload,
                    color: Colors.black,
                  ),
                ],
              ),
              onPressed: () {
                startProgress();
              },
            ),
          ),
          Expanded(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 0.0,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
                  Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          )
        ])
      ],
    );
  }
}
