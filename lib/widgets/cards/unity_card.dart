import 'package:attend/core/values/attend_colors.dart';
import 'package:flutter/material.dart';

class UnityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-1.0, 0.0),
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
            color: AttendColors.unity_container,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        child: Center(
            child: Text(
          "Dermatologia",
          style: TextStyle(color: AttendColors.white, fontSize: 20),
        )),
      ),
    );
  }
}
