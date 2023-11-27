import 'dart:convert';

import 'package:attend/services/API.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QueueService {
  static Future<int> enterInQueue(String lineId) async {
    int statusCode = -1;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var studentId = prefs.getString("id");

    await http
        .post(
            Uri.parse(API.BASE_URL + API.LINE_PREFIX + lineId + "/enterInLine"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"studentId": studentId}))
        .then((response) {
      statusCode = response.statusCode;
    });

    return statusCode;
  }
}
