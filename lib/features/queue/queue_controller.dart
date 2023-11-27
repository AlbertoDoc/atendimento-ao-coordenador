import 'dart:async';

import 'package:attend/models/university.dart';
import 'package:attend/models/student.dart';
import 'package:attend/services/university_service.dart';
import 'package:attend/services/line_service.dart';

abstract class QueueController {
  Stream<University> get universityInfoState;
  Stream<String> get coordinatorNameState;
  Stream<List<Student>> get studentListState;

  void onUniversityInfoChange(String universityId);
  void onCoordinatorNameChange(String universityId, String coordinatorId);
  void onStudentListChange(String universityId, String coordinatorId);
}

class QueueImpl extends QueueController {
  final _universityInfoController = StreamController<University>();
  final _coordinatorNameController = StreamController<String>();
  final _studentListController = StreamController<List<Student>>();

  @override
  Stream<University> get universityInfoState =>
      _universityInfoController.stream;

  @override
  Stream<String> get coordinatorNameState => _coordinatorNameController.stream;

  @override
  Stream<List<Student>> get studentListState => _studentListController.stream;

  @override
  void onUniversityInfoChange(String univeristyId) {
    UniversityService.getUniversityOverviewAndCoordinators(univeristyId)
        .then((response) {
      if (response != null) {
        var universityJson = response["data"]["university"];

        _universityInfoController.sink.add(new University(
            universityJson["id"],
            universityJson["name"],
            universityJson["address"],
            universityJson["phone"]));
      }
    });
  }

  @override
  void onCoordinatorNameChange(String universityId, String coordinatorId) {
    LineService.getCoordinator(universityId, coordinatorId).then((value) {
      print(value);
      _coordinatorNameController.sink.add(value);
    });
  }

  @override
  void onStudentListChange(String universityId, String coordinatorId) {
    LineService.getStudents(universityId, coordinatorId).then((value) {
      print(value);
      _studentListController.sink.add(value);
    });
  }

  void dispose() {
    _universityInfoController.close();
    _coordinatorNameController.close();
    _studentListController.close();
  }
}
