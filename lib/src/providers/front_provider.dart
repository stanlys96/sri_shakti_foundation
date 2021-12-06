import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PageState {
  IDLE,
  FRONT_PAGE,
  LOGIN_PAGE,
  REGISTER_PAGE,
  RESET_PASSWORD_PAGE,
  ENTER_CODE_PAGE,
  NEW_PASSWORD_PAGE
}

class FrontProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  PageState state = PageState.IDLE;
  PageState currentState = PageState.FRONT_PAGE;

  switchState() {
    currentState = state;
    state = PageState.IDLE;
  }
}
