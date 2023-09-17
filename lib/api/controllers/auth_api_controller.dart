import 'dart:convert';

import 'package:elancer_api/api/api_setting.dart';
import 'package:elancer_api/helpers/helpers.dart';
import 'package:elancer_api/models/students.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthApiController with Helpers {

  Future<bool> register(BuildContext context, {required Students students}) async {
    var url = Uri.parse(ApiSetting.register);
    var response = await http.post(url, body: {
      'full_name': students.fullName,
      'email': students.email,
      'password': students.password,
      'gender': students.gender
    });

    if (response.statusCode == 201) {
      showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],

      );
      return true;
    } else if (response.statusCode == 400) {
       showSnackBar(
        context: context,
        message: jsonDecode(response.body)['message'],
        error: true,
      );
    }
    return false;
  }
}
