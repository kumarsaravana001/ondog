import 'package:flutter/material.dart';
import '../config/config_index.dart';

class ScrollableElongatedCardWidget extends StatelessWidget {
  final String label;
  final String sublabel;
  final String sublabel1;
  final VoidCallback onPressed;

  const ScrollableElongatedCardWidget(
      {super.key,
      required this.label,
      required this.sublabel,
      required this.sublabel1,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      // width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Stack(
                children: [
                  AppImages.dummyimage(height: 175),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalisation.registernowex,
                          style: AppTestStyle.headingint(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Text(
                          AppLocalisation.coffeewithcrypto,
                          style: AppTestStyle.headingBai(
                              color: AppColors.white,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          AppLocalisation.interactwithcreators,
                          style: AppTestStyle.headingint(
                              color: AppColors.white,
                              italic: true,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
