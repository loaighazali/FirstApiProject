import 'dart:convert';
import 'dart:io';

import 'package:elancer_api/api/api_setting.dart';
import 'package:elancer_api/helpers/helpers.dart';
import 'package:elancer_api/models/students.dart';
import 'package:elancer_api/pref/shared_pref_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthApiController with Helpers {

  Future<bool> register(BuildContext context,
      {required Students students}) async {
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

  Future<bool> login(BuildContext context,
      {required String email, required String password}) async {
    var url = Uri.parse(ApiSetting.login);
    var response = await http.post(url, body: {
      'email': email,
      'password': password
    });

    if (response.statusCode == 200) {
      var jesonOpject = jsonDecode(response.body)['object'];
      Students students = Students.fromJson(jesonOpject);
       SharedPrefController().save(students: students);
      showSnackBar(
          context: context, message: jsonDecode(response.body)['message']);
      return true;
    }else if(response.statusCode == 400){
    showSnackBar(context: context, message: jsonDecode(response.body)['message'] , error: true,);
    return false ;
    }
    return
    false;
  }

  Future<bool> logOut ()async{
    var url = Uri.parse(ApiSetting.logout);
    var response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader : SharedPrefController().token,
      HttpHeaders.acceptHeader : 'application/json'
    });

    if(response.statusCode == 200 || response.statusCode == 401){
      SharedPrefController().clear();
      return true;
    }
    return false ;

  }
}
