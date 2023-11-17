// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../../config/config_index.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  _CheckboxListState createState() => _CheckboxListState();
}

class _CheckboxListState extends State<LanguageScreen> {
  bool isAudioEnglish = false;
  bool isAudioHindi = false;
  bool isAudioSpanish = false;
  bool isAudioFrench = false;
  bool isAudioGerman = false;
  bool isAudioItalian = false;

  bool isSubtitleEnglish = false;
  bool isSubtitleHindi = false;
  bool isSubtitleSpanish = false;
  bool isSubtitleFrench = false;
  bool isSubtitleGerman = false;
  bool isSubtitleItalian = false;

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
              child: SvgPicture.asset(IconAssets.bottombgdiamond),
            ),
            Column(
              children: [
                SvgPicture.asset(
                    width: MediaQuery.of(context).size.width,
                    IconAssets.profilescreenbgblack),
                Align(
                    alignment: Alignment.center,
                    child: Text(AppLocalisation.language,
                        style: AppTestStyle.headingBai(fontSize: 28.sp))),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 30.sp, top: 20.sp, bottom: 15.sp),
                      child: Text(AppLocalisation.audio,
                          style: AppTestStyle.headingBai(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25))),
                ),
                GridView.count(
                    childAspectRatio: 5,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 30.sp),
                    children: [
                      CheckboxRow(
                          text: AppLocalisation.english,
                          isAudiochecked: isAudioEnglish,
                          onChanged: (value) {
                            setState(() {
                              isAudioEnglish = value;
                            });
                          }),
                      CheckboxRow(
                          text: AppLocalisation.french,
                          isAudiochecked: isAudioFrench,
                          onChanged: (value) {
                            setState(() {
                              isAudioFrench = value;
                            });
                          }),
                      CheckboxRow(
                          text: AppLocalisation.hindi,
                          isAudiochecked: isAudioHindi,
                          onChanged: (value) {
                            setState(() {
                              isAudioHindi = value;
                            });
                          }),
                      CheckboxRow(
                          text: AppLocalisation.german,
                          isAudiochecked: isAudioGerman,
                          onChanged: (value) {
                            setState(() {
                              isAudioGerman = value;
                            });
                          }),
                      CheckboxRow(
                          text: AppLocalisation.spanish,
                          isAudiochecked: isAudioSpanish,
                          onChanged: (value) {
                            setState(() {
                              isAudioSpanish = value;
                            });
                          }),
                    ]),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 30.sp, top: 20.sp, bottom: 15.sp),
                      child: Text(AppLocalisation.subtitle,
                          style: AppTestStyle.headingBai(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25))),
                ),
                GridView.count(
                    childAspectRatio: 5,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 30.sp),
                    children: [
                      CheckboxRow(
                          text: AppLocalisation.english,
                          isAudiochecked: isSubtitleEnglish,
                          onChanged: (value) {
                            setState(() {
                              isAudioEnglish = value;
                            });
                          }),
                      CheckboxRow(
                          text: AppLocalisation.french,
                          isAudiochecked: isSubtitleFrench,
                          onChanged: (value) {
                            setState(() {
                              isSubtitleFrench = value;
                            });
                          }),
                      CheckboxRow(
                          text: AppLocalisation.hindi,
                          isAudiochecked: isSubtitleHindi,
                          onChanged: (value) {
                            setState(() {
                              isSubtitleHindi = value;
                            });
                          }),
                      CheckboxRow(
                          text: AppLocalisation.german,
                          isAudiochecked: isSubtitleGerman,
                          onChanged: (value) {
                            setState(() {
                              isSubtitleGerman = value;
                            });
                          }),
                      CheckboxRow(
                          text: AppLocalisation.spanish,
                          isAudiochecked: isSubtitleSpanish,
                          onChanged: (value) {
                            setState(() {
                              isSubtitleSpanish = value;
                            });
                          }),
                    ]),
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

class CheckboxRow extends StatelessWidget {
  final String text;
  final bool isAudiochecked;

  final Function(bool) onChanged;

  const CheckboxRow({
    super.key,
    required this.text,
    required this.isAudiochecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomSquareCheckbox(
          checked: isAudiochecked,
          onChanged: onChanged,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 16, color: AppColors.black),
        ),
      ],
    );
  }
}

class CustomSquareCheckbox extends StatelessWidget {
  final bool checked;
  final Function(bool)? onChanged;

  const CustomSquareCheckbox(
      {super.key, required this.checked, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged?.call(!checked);
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: checked ? Colors.blue : Colors.transparent,
        ),
        child: checked
            ? const Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
