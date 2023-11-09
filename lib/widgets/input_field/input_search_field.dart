import 'package:attend/core/values/attend_colors.dart';
import 'package:attend/core/values/text_styles.dart';
import 'package:attend/widgets/select_box/round_selected_box.dart';
import 'package:flutter/material.dart';

class InputSearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function onChanged;
  final SelectBoxType selectType;

  InputSearchField({
    required this.controller,
    required this.onChanged,
    required this.selectType,
  });

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
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        hintText: 'Buscar Universidades...',
        hintStyle: TextStyles.hintField,
        enabledBorder: _setBorder(AttendColors.input_border),
        focusedBorder: _setBorder(AttendColors.main_primary),
        prefixIcon: Icon(
          Icons.search,
          color: AttendColors.main_primary,
        ),
      ),
    );
  }

  InputBorder _setBorder(Color color) {
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
