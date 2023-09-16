import 'dart:convert';

import 'package:elancer_api/api/api_setting.dart';
import 'package:elancer_api/models/api_base_response.dart';
import 'package:elancer_api/models/user.dart';
import 'package:http/http.dart' as http;

class UserApiController {

  Future<List<User>> getUsers() async{
    var url = Uri.parse(ApiSetting.users);
    var response =await http.get(url);

    if(response.statusCode == 200){
        var jsonResponse = jsonDecode(response.body);
        ApiBaseResponse baseResponse = ApiBaseResponse.fromJson(jsonResponse);
        return baseResponse.data;
    }
    else{
      //Show Message Error
    }
    return [];
  }


}