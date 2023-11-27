import 'dart:async';

import 'package:attend/models/university.dart';
import 'package:attend/models/coordinator.dart';
import 'package:attend/services/university_service.dart';

abstract class UniversityOverviewController {
  Stream<String> get searchState;
  Stream<University> get universityInfoState;
  Stream<List<Coordinator>> get coordinatorListState;

  void onSearchChange(String text);
  void onUniversityInfoChange(String universityId);
  void onCoordinatorListChange(List<Coordinator> coordinatorList);
  void dispose();
}

class UniversityOverviewImpl extends UniversityOverviewController {
  final _searchFieldController = StreamController<String>();
  final _universityInfoController = StreamController<University>();
  final _coordinatorListController = StreamController<List<Coordinator>>();

  @override
  Stream<String> get searchState => _searchFieldController.stream;

  @override
  Stream<University> get universityInfoState =>
      _universityInfoController.stream;

  @override
  Stream<List<Coordinator>> get coordinatorListState =>
      _coordinatorListController.stream;

  @override
  void onSearchChange(String text) {
    // TODO integration with api and apply debouncer
    _searchFieldController.add(text);
  }

  @override
  void onUniversityInfoChange(String universityId) {
    UniversityService.getUniversityOverviewAndCoordinators(universityId)
        .then((response) {
      print(response);
      if (response != null) {
        var universityJson = response["data"]["university"];

        var coordinatorsJson = response["data"]["coordinators"];
        List<Coordinator> coordinatorList = [];
        for (var item in coordinatorsJson) {
          coordinatorList.add(new Coordinator(
              item["id"], item["name"], item["isAttendingToday"]));
        }

        onCoordinatorListChange(coordinatorList);

        _universityInfoController.sink.add(new University(
            universityJson["id"],
            universityJson["name"],
            universityJson["address"],
            universityJson["phone"]));
      }
    });
  }

  @override
  void onCoordinatorListChange(List<Coordinator> coordinatorList) {
    _coordinatorListController.sink.add(coordinatorList);
  }

  @override
  void dispose() {
    _searchFieldController.close();
    _universityInfoController.close();
    _coordinatorListController.close();
  }
}
