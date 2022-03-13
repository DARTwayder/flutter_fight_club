import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';

import 'package:flutter_fight_club/resources/fight_club_colors.dart';

import '../resources/fight_club_images.dart';

class FightResultWidget extends StatelessWidget {
  final FightResult fightResult;

  const FightResultWidget({Key? key,required this.fightResult}) : super(key: key);



  @override
  Widget build(BuildContext context) {
     return SizedBox(
      height: 140,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Expanded(
                  child: ColoredBox(
                    color: Colors.white,
                  )),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    gradient: LinearGradient(
                      colors: [Colors.white, FightClubColors.darkPurple],
                    ),
                  ),
                ),
              ),
              Expanded(child: ColoredBox(color: FightClubColors.darkPurple)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "You",
                    style: TextStyle(color: FightClubColors.darkGreyText),
                  ),
                  const SizedBox(height: 12),
                  Image.asset(FightClubImages.youAvatar, height: 92, width: 92),
                ],
              ),
              const SizedBox(
                height: 44,
                width: 44,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: FightClubColors.blueButton,
                  ),
                  child: Center(
                      child: Text("vs",
                          style: TextStyle(color: Colors.white, fontSize: 16))),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Enemy",
                    style: TextStyle(color: FightClubColors.darkGreyText),
                  ),
                  const SizedBox(height: 12),
                  Image.asset(FightClubImages.enemyAvatar,
                      height: 92, width: 92),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}

