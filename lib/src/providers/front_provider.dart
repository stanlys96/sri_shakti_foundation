import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sri_shakti_foundation/src/models/register_model.dart';
import 'package:sri_shakti_foundation/src/uis/front_ui.dart';
import 'package:sri_shakti_foundation/src/views/front_view.dart';
import 'package:sri_shakti_foundation/src/providers/base_provider.dart';

Dio customDio() {
  Dio dio = new Dio();

  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true));

  return dio;
}

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
  String baseUrl = "https://sri-shakti-foundation.herokuapp.com/users";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  FrontView? view;

  PageState state = PageState.IDLE;
  PageState currentState = PageState.FRONT_PAGE;

  bool _loading = false;
  bool _registerSuccess = false;

  bool get loading => _loading;

  bool get registerSuccess => _registerSuccess;

  set registerSuccess(bool value) {
    _registerSuccess = value;
    notifyListeners();
  }

  doRegister(
      {required Map<String, dynamic> params,
      FormController? controller}) async {
    showLoading();
    var response = await customDio().post("$baseUrl/register", data: params);
    RegisterResponseModel result =
        RegisterResponseModel.fromJson(response.data);
    if (result.message == "Success") {
      print("Success!");
      removeLoading();
      registerSuccess = true;
      notifyListeners();
      view?.backToFrontPage();
      controller?.clear();
    } else if (result.message == "Email is already registered!") {
      print("Email is already registered!");
      removeLoading();
      view?.showMessage(result.message);
    } else {
      print("Ey!");
    }
  }

  switchState() {
    currentState = state;
    state = PageState.IDLE;
  }

  showLoading() {
    _loading = true;
    notifyListeners();
  }

  removeLoading() {
    _loading = false;
    notifyListeners();
  }

  resetValue() {
    _loading = false;
    state = PageState.IDLE;
    currentState = PageState.FRONT_PAGE;
  }

  dispose() {
    resetValue();
    super.dispose();
  }
}
