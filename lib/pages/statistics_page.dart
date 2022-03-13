import 'package:flutter/material.dart';

import '../resources/fight_club_colors.dart';
import '../widgets/secondary_action_button.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, top: 24),
            alignment: Alignment.center,
            child: const Text("Statistics",
                style: TextStyle(
                    fontSize: 24, color: FightClubColors.darkGreyText)),
          ),
          const Expanded(child: SizedBox.shrink()),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SecondaryActionButton(
              text: "Back",
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ]),
      ),
    );
  }
}
