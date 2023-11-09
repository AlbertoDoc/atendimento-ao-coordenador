import 'dart:convert';

import 'package:attend/models/student.dart';
import 'package:attend/services/API.dart';

import 'package:http/http.dart' as http;

class LineService {
  static Future<String> getCoordinator(
      String universityId, String coordinatorId) async {
    String coordinatorName = "";

    await http
        .get(
      Uri.parse(API.BASE_URL +
          API.UNIVERSITY_PREFIX +
          universityId +
          "/coordinators/" +
          coordinatorId +
          "/line"),
    )
        .then((response) {
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        coordinatorName =
            jsonDecode(response.body)["data"]["coordinator"]["name"];
      }
    });

    return coordinatorName;
  }

  static Future<List<Student>> getStudents(
      String universityId, String coordinatorId) async {
    List<Student> students = [];

    await http
        .get(
      Uri.parse(API.BASE_URL +
          API.UNIVERSITY_PREFIX +
          universityId +
          "/coordinators/" +
          coordinatorId +
          "/line"),
    )
        .then((response) {
      if (response.statusCode == 200) {
        var body = response.body;
        var studentsJson = jsonDecode(body)["data"]["line"]["students"];

        print(studentsJson);

        for (var item in studentsJson) {
          students.add(new Student(
              item["id"], item["waitingTime"], item["name"], item["position"]));
        }
      }
    });

    return students;
  }

  static Future<String> getLine(
      String universityId, String coordinatorId) async {
    var lineId = "";

    var response = await http.get(
      Uri.parse(API.BASE_URL +
          API.UNIVERSITY_PREFIX +
          universityId +
          "/coordinators/" +
          coordinatorId +
          "/line"),
    );

    if (response.statusCode == 200) {
      var body = response.body;
      lineId = jsonDecode(body)["data"]["line"]["id"];
    }

    return lineId;
  }
}
