import 'package:attend/core/values/attend_colors.dart';
import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final int position;
  final String waitingTime;

  StudentCard(this.name, this.position, this.waitingTime);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        color: AttendColors.student_container,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  position.toString() + "º",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  _formatTime(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime() {
    var formatedWaitingTime = "";

    var hour = waitingTime.split(":")[1];
    var minutes = waitingTime.split(":")[2];

    if (hour != "00") {
      formatedWaitingTime += hour + "h";
    } else if (minutes != "00") {
      formatedWaitingTime += minutes + "min";
    }

    return formatedWaitingTime;
  }
}
