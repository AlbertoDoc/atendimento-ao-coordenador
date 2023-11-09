import 'package:attend/core/assets/images/images.dart';
import 'package:attend/core/values/attend_colors.dart';
import 'package:attend/core/values/dimens.dart';
import 'package:attend/core/values/text_styles.dart';
import 'package:attend/features/universityOverview/university_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CustomCard extends StatelessWidget {
  final String universityId;
  final String universityName;

  CustomCard(this.universityId, this.universityName);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.card_padding),
      child: InkWell(
        onTap: () => {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UniversityOverviewPage(universityId)))
        },
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _cardImage(context),
              _cardInfo(
                context,
                text: universityName,
              ),
            ],
          ),
          color: AttendColors.university_box,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              Dimens.card_border_radius,
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardImage(BuildContext context) {
    return Container(
      constraints: Dimens.universityImageConstraint,
      width: MediaQuery.of(context).size.width * Dimens.card_width_ratio,
      height: MediaQuery.of(context).size.height * Dimens.card_height_ratio,
      child: Image.asset(
        Images.example_image,
      ),
    );
  }

  Widget _cardInfo(BuildContext context, {required String text}) {
    return Container(
      constraints: Dimens.universityTextConstraint,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * Dimens.card_width_ratio,
      height: MediaQuery.of(context).size.height * Dimens.card_height_ratio,
      child: AutoSizeText(
        text,
        textAlign: TextAlign.center,
        style: TextStyles.universityListText,
        minFontSize: 10,
      ),
    );
  }
}
