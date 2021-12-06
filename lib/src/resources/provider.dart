// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sri_shakti_foundation/src/resources/helper.dart';
//
// class ProviderWidget extends StatefulWidget {
//   final dynamic arguments = {};
//
//   @override
//   ProviderState createState() => ProviderState();
// }
//
// class ProviderState<T extends ProviderWidget> extends State<T>
//     implements BaseView {
//   dynamic arguments;
//
//   GlobalKey key = new GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     super.initState();
//     arguments = widget.arguments != null && widget.arguments[kDataLower] != null
//         ? widget.arguments[kDataLower]
//         : {};
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
//
//   @override
//   void showMessageDialog({required String title, required String content}) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) => new CupertinoAlertDialog(
//               title: new Text(title),
//               content: new Text(content),
//               actions: <Widget>[
//                 CupertinoDialogAction(
//                   isDefaultAction: true,
//                   child: Text(kOk),
//                   onPressed: () {
//                     navigator.pop();
//                   },
//                 ),
//               ],
//             ));
//   }
//
//   void showMessage(String message) {
//     showSnackBar(key: key, message: message);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
