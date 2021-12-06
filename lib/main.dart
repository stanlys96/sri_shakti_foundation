import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sri_shakti_foundation/src/providers/front_provider.dart';
import 'package:sri_shakti_foundation/src/resources/helper.dart';
import 'package:sri_shakti_foundation/src/uis/front_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((value) {
    bool _loggedIn;

    String? str = value.getString(kMemberLower);
    if (str == null || str.isEmpty) {
      _loggedIn = false;
    } else {
      _loggedIn = true;
    }
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FrontProvider(),
        )
      ],
      child: Main(
        loggedIn: false,
      ),
    ));
  });
}

class Main extends StatelessWidget {
  final bool loggedIn;

  Main({required this.loggedIn});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'Sri Shakti Foundation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FrontUI(),
      },
    );
  }
}
