// import 'package:flutter/material.dart';
// import 'package:sri_shakti_foundation/src/resources/helper.dart';
//
// Widget? makeRoute(
//     {required BuildContext context,
//     required String routeName,
//     Object? arguments}) {
//   final Widget? child = _buildRoute(
//       context: context, routeName: routeName, arguments: arguments!);
//   return child;
// }
//
// Widget? _buildRoute({
//   required BuildContext context,
//   required String routeName,
//   Object? arguments,
// }) {
//   Map<String, Widget> routes = {
//     kMainRoute: FrontUI(),
//     kAppRoute: AppUI(),
//   };
//   Widget? widget = routes[routeName];
//   (widget as ProviderWidget).arguments[kDataLower] = arguments;
//   return widget;
// }
