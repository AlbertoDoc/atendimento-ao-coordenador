import 'package:attend/core/values/attend_colors.dart';
import 'package:attend/features/queue/queue_controller.dart';
import 'package:attend/models/university.dart';
import 'package:attend/models/student.dart';
import 'package:attend/services/line_service.dart';
import 'package:attend/services/queue_service.dart';
import 'package:attend/widgets/cards/student_card.dart';
import 'package:flutter/material.dart';

class QueuePage extends StatefulWidget {
  final String coordinatorId;
  final String universityId;

  QueuePage(this.coordinatorId, this.universityId);

  @override
  _QueuePageState createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  final _controller = QueueImpl();
  String lineId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            _universityInfo(),
            SizedBox(
              height: 20,
            ),
            Text(
              "Fila de Atendimento",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            _coordinatorView(),
            _listHeader(),
            _divider(),
            _queue(),
            _enterInQueue()
          ],
        ),
      ),
    );
  }

  Widget _universityInfo() {
    return StreamBuilder<University>(
        stream: _controller.universityInfoState,
        builder: (context, snapshot) {
          final university = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                Text(
                  university == null ? "" : university.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(university == null ? "" : university.address),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone),
                    Text(
                      university == null ? "" : university.phone,
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  Widget _coordinatorView() {
    return StreamBuilder<String>(
        stream: _controller.coordinatorNameState,
        initialData: "",
        builder: (context, snapshot) {
          final String coordinatorName = snapshot.data as String;
          return Align(
            alignment: Alignment(-1.0, 0.0),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AttendColors.unity_container,
              ),
              child: Center(
                  child: Text(
                coordinatorName,
                style: TextStyle(color: AttendColors.white, fontSize: 20),
              )),
            ),
          );
        });
  }

  Widget _listHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Posição",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Text(
            "Nome",
            style: TextStyle(fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Text(
              "Tempo",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
      child: Divider(
        thickness: 2,
        color: Colors.black,
      ),
    );
  }

  Widget _queue() {
    return StreamBuilder<List<Student>>(
        stream: _controller.studentListState,
        initialData: [],
        builder: (context, snapshot) {
          final listStudent = snapshot.data as List<Student>;
          final listStudentWidget = listStudent.map((item) {
            return StudentCard(item.name, item.position, item.waitingTime);
          }).toList();
          return ListView.builder(
              shrinkWrap: true,
              itemCount: listStudentWidget.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return listStudentWidget[index];
              });
        });
  }

  Widget _enterInQueue() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: 250, height: 50),
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    AttendColors.unity_container),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: AttendColors.unity_container)))),
            onPressed: () {
              QueueService.enterInQueue(lineId).then((statusCode) {
                if (statusCode == 201) {
                  _controller.onStudentListChange(
                      widget.universityId, widget.coordinatorId);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Erro ao entrar na fila!")));
                }
              });
            },
            child: Text(
              "ENTRAR NA FILA",
              style: TextStyle(fontSize: 18, color: Colors.white),
            )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.onUniversityInfoChange(widget.universityId);
    _controller.onCoordinatorNameChange(
        widget.universityId, widget.coordinatorId);
    _controller.onStudentListChange(widget.universityId, widget.coordinatorId);

    LineService.getLine(widget.universityId, widget.coordinatorId)
        .then((value) {
      lineId = value;
    });
  }
}
