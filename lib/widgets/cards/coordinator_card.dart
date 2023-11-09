import 'package:attend/core/values/attend_colors.dart';
import 'package:attend/features/queue/queue_screen.dart';
import 'package:flutter/material.dart';

class CoordinatorCard extends StatelessWidget {
  final String id;
  final String name;
  final bool isAttendingToday;

  final String universityId;

  CoordinatorCard(this.id, this.name, this.isAttendingToday, this.universityId);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AttendColors.coordinator_container,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        color: AttendColors.coordinator_container,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QueuePage(id, universityId)));
          },
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Icon(
                isAttendingToday ? Icons.verified : Icons.close,
                color: isAttendingToday ? Colors.green : Colors.red,
              ),
              SizedBox(
                width: 5,
              ),
              Text(name)
            ],
          ),
        ),
      ),
    );
  }
}
