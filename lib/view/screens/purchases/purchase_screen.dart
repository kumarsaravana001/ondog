import 'package:flutter/material.dart';
import 'package:ondgo_flutter/utilities/app_banner_list.dart';

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
                  child: ElongatedCardWidget(
                    cardlength: purchadeimagePaths.length,
                    imageList: purchadeimagePaths,
                    sublabel: AppLocalisation.coffeewithcrypto,
                    label: AppLocalisation.offer,
                    amount: AppLocalisation.inramount,
                    date: AppLocalisation.date,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 30,
              child: Row(
                children: [SvgPicture.asset(IconAssets.badgeopen)],
              ),
            ),
            Positioned(
              top: 10,
              left: 20,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.arrow_back_outlined,
                        color: AppColors.white, size: 30),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
