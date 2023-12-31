import 'dart:async';

import 'package:attend/models/select_box_state.dart';
import 'package:attend/services/university_service.dart';
import 'package:attend/widgets/cards/custom_card.dart';
import 'package:attend/widgets/select_box/round_selected_box.dart';

abstract class HomeController {
  Stream<List<SelectBoxState>> get selectState;
  Stream<String> get searchState;
  Stream<List<CustomCard>> get listState;

  void onSearchChange(String text);
  void onSelectHandler({SelectBoxType type = SelectBoxType.university});
  void onListChange(String text);
  void dispose();
}

class HomeControllerImpl extends HomeController {
  final _selectBoxController = StreamController<List<SelectBoxState>>();
  final _searchFieldController = StreamController<String>();
  final _listController = StreamController<List<CustomCard>>();

  @override
  Stream<List<SelectBoxState>> get selectState => _selectBoxController.stream;

  @override
  Stream<String> get searchState => _searchFieldController.stream;

  @override
  Stream<List<CustomCard>> get listState => _listController.stream;

  @override
  void onSelectHandler({SelectBoxType type = SelectBoxType.university}) {
    final boxStates = _generateBaseState(type);

    _selectBoxController.add(boxStates);
  }

  @override
  void onSearchChange(String text) {
    onListChange(text);
    // TODO integration with api and apply debouncer
    _searchFieldController.add(text);
  }

  @override
  void onListChange(String text) {
    List<CustomCard> customCards = [];
    UniversityService.searchUniversity(text).then((universities) {
      for (var item in universities) {
        customCards.add(CustomCard(item.id, item.name));
      }

      _listController.sink.add(customCards);
    });
  }

  @override
  void dispose() {
    _searchFieldController.close();
    _selectBoxController.close();
    _listController.close();
  }

  List<SelectBoxState> _generateBaseState(SelectBoxType type) {
    List<SelectBoxState> boxStates = [];
    for (var value in SelectBoxType.values) {
      boxStates.add(SelectBoxState(
        type: value,
        selected: value == type,
      ));
    }

    return boxStates;
  }
}
