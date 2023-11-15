import 'package:attend/core/values/attend_colors.dart';
import 'package:attend/core/values/text_styles.dart';
import 'package:flutter/material.dart';

class InputSearchFieldUniversity extends StatelessWidget {
  final TextEditingController controller;
  final Function onChanged;

  InputSearchFieldUniversity(
      {required this.controller, required this.onChanged});

  void onChangedWrapper(String text) {
    onChanged(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChangedWrapper,
      controller: controller,
      style: TextStyles.inputField,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        hintText: 'Buscar Coordenador...',
        hintStyle: TextStyles.hintField,
        enabledBorder: _setBorder(color: AttendColors.input_border),
        focusedBorder: _setBorder(color: AttendColors.main_primary),
        prefixIcon: Icon(
          Icons.search,
          color: AttendColors.main_primary,
        ),
      ),
    );
  }

  InputBorder _setBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }
}
