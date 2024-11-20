import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

import '../../../../../../constants/api_constants.dart';

class AuthRepo {
 //// api request for signup
  Future<Response> registerUser(
      {password,
      phoneNumber,
      firstName,
      lastName,
      email,
      confirmPasssword,
      userName}) async {
    var body = {
      "username": userName,
      "email": email,
      "password": password,
      "first_name": firstName,
      "last_name": lastName,
      "mobile_number": phoneNumber,
      "password_confirmation": confirmPasssword
      // "fcmToken": PushNotificationHelper.fcmToken
    };
    return await post(Uri.parse(ApiConstants.registerUrl),
        headers: ApiHeaders.unaunthenticatedHeader, body: jsonEncode(body));
  }

////api request fo login
  Future<Response> loginUser({password, email}) async {
    var body = {"email": email, "password": password};
    log(body.toString());
    return await post(Uri.parse(ApiConstants.loginUrl),
        headers: ApiHeaders.unaunthenticatedHeader, body: jsonEncode(body));
  }
}
