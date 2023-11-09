import 'dart:convert';

import 'package:attend/services/API.dart';
import 'package:http/http.dart' as http;

class QueueService {
  static Future<int> enterInQueue(String lineId, String studentId) async {
    int statusCode = -1;

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