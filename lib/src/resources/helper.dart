import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kMainRoute = "/";
const kAppRoute = "appPage";

const kMemberLower = "member";
const kDataLower = "data";
const kSignUp = "Sign Up";
const kLogin = "Login";
const kForgotPasswordUpper = "FORGOT YOUR PASSWORD? ";
const kResetNowUpper = "RESET NOW";
const kName = "Name";
const kNameLower = "name";
const kGraduatedYear = "Graduated Year";
const kGraduateLower = "graduate";
const kEmail = "Email";
const kEmailLower = "email";
const kPassword = "Password";
const kPasswordLower = "password";
const kIdentifierLower = "id";
const kAlertEmailEmpty = "Email cannot be empty.";
const kAlertPasswordEmpty = "Password cannot be empty.";
const kAlertNameEmpty = "Name cannot be empty";
const kAlertGraduateEmpty = "Graduated year cannot be empty";
const kAlertAgeEmpty = "Age cannot be empty";
const kSignupHereUpper = "Sign Up Here";
const kNewMember = "New Member? ";
const kAgeLower = "age";
const kAge = "Age";
const kSignupSuccess = "Sign up success!";
const kAlertSignupSuccess = "Sign up success!";

void showSnackBar({required GlobalKey key, required String? message}) {
  ScaffoldMessenger.of(key.currentContext!).showSnackBar(
    SnackBar(
      content: Text(message!),
      duration: Duration(seconds: 3),
    ),
  );
}
