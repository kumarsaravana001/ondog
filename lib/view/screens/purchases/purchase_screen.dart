import 'package:flutter/material.dart';

import '../../../config/config_index.dart';
import '../../../utilities/app_elongated_card.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              bottom: -125,
              left: -10,
              right: 30,
              child: SvgPicture.asset(
                  width: MediaQuery.of(context).size.width,
                  IconAssets.bottombgdiamond),
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
                        amount: AppLocalisation.inramount,
                        date: AppLocalisation.date,
                        sublabel: AppLocalisation.coffeewithcrypto,
                        label: AppLocalisation.coffeesession,
                        onPressed: () {},
                      ),
                      ElongatedCardWidget(
                        amount: AppLocalisation.inramount,
                        date: AppLocalisation.date,
                        sublabel: AppLocalisation.coffeewithcrypto,
                        label: AppLocalisation.coffeesession,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 30,
              child: Row(
                children: [SvgPicture.asset(IconAssets.badgeclose)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
