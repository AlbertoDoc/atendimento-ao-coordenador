import 'dart:convert';

import 'package:attend/models/university.dart';
import 'package:http/http.dart' as http;

import 'API.dart';

class UniversityService {
  static Future<List<University>> searchUniversity(String searchString) async {
    List<University> universities = [];

    await http
        .post(Uri.parse(API.BASE_URL + API.UNIVERSITY_PREFIX),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"search": searchString}))
        .then((response) {
      //TODO Implement error treatment
      dynamic body = jsonDecode(response.body);
      dynamic universityJson = body["data"]["universities"];

      for (var item in universityJson) {
        universities.add(new University(item["id"], item["name"], "", ""));
      }

      return universities;
    });

    return universities;
  }

  static Future<dynamic> getUniversityOverviewAndCoordinators(
      String universityId) async {
    dynamic retorno;

    await http
        .get(
      Uri.parse(API.BASE_URL +
          API.UNIVERSITY_PREFIX +
          universityId +
          "/coordinators"),
    )
        .then((response) {
      retorno = jsonDecode(response.body);
    });

    return retorno;
  }
}
