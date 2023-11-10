import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ondgo_flutter/utilities/app_elongated_card.dart';

import '../../../config/app_textstyle.dart';
import '../../../config/config_index.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: -125,
            left: -10,
            right: 30,
            child: SvgPicture.asset(IconAssets.bottombgdiamond),
          ),
          Column(
            children: [
              SvgPicture.asset(
                  width: MediaQuery.of(context).size.width,
                  IconAssets.profilescreenbgblack),
              Align(
                  alignment: Alignment.center,
                  child: Text(AppLocalisation.purchase,
                      style: AppTestStyle.headingBai(fontSize: 28.sp))),
              Expanded(
                child: ListView(
                  children: [
                    ElongatedCardWidget(
                      sublabel: AppLocalisation.coffeewithcrypto,
                      label: AppLocalisation.offer,
                      amount: AppLocalisation.inramount,
                      date: AppLocalisation.date,
                      onPressed: () {},
                    ),
                    ElongatedCardWidget(
                      sublabel: AppLocalisation.designhinking,
                      label: AppLocalisation.freeentry,
                      amount: AppLocalisation.inramount,
                      date: AppLocalisation.date,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
