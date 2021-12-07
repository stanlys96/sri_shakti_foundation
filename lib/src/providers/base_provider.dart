import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum Type { ADD, EDIT, VIEW }

class BaseProvider extends ChangeNotifier {
  String parseError(dynamic error) {
    try {
      return (error as DioError).response?.data["message"][0]["messages"][0]
          ["message"];
    } catch (e) {
      return ((error as DioError).response?.data["data"]["errors"]
              as Map<String, dynamic>)
          .values
          .first[0]
          .toString();
    }
  }
}
