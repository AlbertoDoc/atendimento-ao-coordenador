import 'package:attend/features/universityOverview/university_overview_controller.dart';
import 'package:attend/models/university.dart';
import 'package:attend/models/coordinator.dart';
import 'package:attend/widgets/cards/coordinator_card.dart';
import 'package:attend/widgets/input_field/input_search_field_university.dart';
import 'package:flutter/material.dart';

class UniversityOverviewPage extends StatefulWidget {
  final String universityId;

  UniversityOverviewPage(this.universityId);

  @override
  _UniversityOverviewPageState createState() => _UniversityOverviewPageState();
}

class _UniversityOverviewPageState extends State<UniversityOverviewPage> {
  final UniversityOverviewController _controller = UniversityOverviewImpl();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  _universityInfo(),
                  SizedBox(
                    height: 20,
                  ),
                  _searchField(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Expanded(child: _coordinatorsList()),
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
          return Column(
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
          );
        });
  }

  Widget _searchField() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: StreamBuilder<String>(
          stream: _controller.searchState,
          initialData: '',
          builder: (context, snapshot) {
            return InputSearchFieldUniversity(
                controller: _searchController,
                onChanged: _controller.onSearchChange);
          }),
    );
  }

  Widget _coordinatorsList() {
    return StreamBuilder(
        stream: _controller.coordinatorListState,
        initialData: [],
        builder: (context, snapshot) {
          final coordinatorsList = snapshot.data as List<Coordinator>;
          final coordinatorsListWidget = coordinatorsList.map((coordinator) {
            return CoordinatorCard(coordinator.id, coordinator.name,
                coordinator.isAttendingToday, widget.universityId);
          }).toList();
          return ListView.builder(
              itemCount: coordinatorsListWidget.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return coordinatorsListWidget[index];
              });
        });
  }

  @override
  void initState() {
    super.initState();
    _controller.onUniversityInfoChange(widget.universityId);
  }
}
