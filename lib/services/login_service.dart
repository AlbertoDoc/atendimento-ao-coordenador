import 'dart:convert';

import 'package:attend/services/API.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static Future<int> login(String email, String password) async {
    var response = await http.post(Uri.parse(API.BASE_URL + API.LOGIN_SUFFIX),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'id', jsonDecode(response.body)["data"]["patientId"]);
    }

    return response.statusCode;
  }
}
