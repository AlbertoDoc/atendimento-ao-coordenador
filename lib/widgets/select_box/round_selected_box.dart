import 'package:attend/core/values/attend_colors.dart';
import 'package:attend/core/values/text_styles.dart';
import 'package:flutter/material.dart';

enum SelectBoxType {
  university,
  unity,
  coordinator,
}

class RoundSelectedBox extends StatelessWidget {
  final SelectBoxType type;
  final Function tapHandler;
  final Function searchHandler;
  final TextEditingController searchController;
  final bool selected;

  RoundSelectedBox({
    required this.type,
    required this.tapHandler,
    required this.searchHandler,
    required this.searchController,
    required this.selected,
  });

  void _tapHandlerWrapper() {
    tapHandler(type: type);

    searchHandler(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _tapHandlerWrapper,
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: selected
                  ? AttendColors.main_primary
                  : AttendColors.unselect_box,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: _iconBox(),
          ),
          SizedBox(
            height: 5,
          ),
          _textInfo(),
        ],
      ),
    );
  }

  Widget _textInfo() {
    String info;
    switch (type) {
      case SelectBoxType.university:
        info = 'Universidade';
        break;
      case SelectBoxType.coordinator:
        info = 'Coordenador';
        break;
      default:
        info = 'Unidade';
        break;
    }

    return Text(
      info,
      style: TextStyles.selectInfoText,
    );
  }

  Widget _iconBox() {
    IconData icon;
    switch (type) {
      case SelectBoxType.university:
        icon = Icons.domain;
        break;
      case SelectBoxType.coordinator:
        icon = Icons.person;
        break;
      default:
        icon = Icons.school;
        break;
    }
    return Icon(
      icon,
      size: 30,
      color: AttendColors.white,
    );
  }
}
