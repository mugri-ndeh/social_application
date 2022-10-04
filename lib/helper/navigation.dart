import 'package:flutter/cupertino.dart';

pushReplacement(BuildContext context, Widget destination) {
  Navigator.of(context)
      .pushReplacement(CupertinoPageRoute(builder: (context) => destination));
}

push(BuildContext context, Widget destination) {
  Navigator.of(context)
      .push(CupertinoPageRoute(builder: (context) => destination));
}

pushAndRemoveUntil(BuildContext context, Widget destination, bool predict) {
  Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => destination),
      (Route<dynamic> route) => predict);
}
