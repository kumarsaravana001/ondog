import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ondgo_flutter/utilities/app_horizontal_scroll_card.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_scrollable_elongated_card.dart';
import '../../../utilities/index.dart';

bool showWatchedContent = false;
bool showQuizContent = false;
bool showScoreContent = false;

class ShowCaseScreen extends StatefulWidget {
  const ShowCaseScreen({super.key});

  @override
  State<ShowCaseScreen> createState() => _ShowCaseScreenState();
}

class _ShowCaseScreenState extends State<ShowCaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                child:
                    Center(child: SvgPicture.asset(IconAssets.appbackground))),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.sp),
                          child: SvgPicture.asset(IconAssets.ondgoTextlogo,
                              semanticsLabel: 'Ondgo Logo'),
                        ),
                        InkWell(
                            onTap: () {
                              context.push("/profile");
                            },
                            child:
                                SvgPicture.asset(IconAssets.badgecloseblack)),
                      ],
                    ),
                  ),
                  showWatchedContent == false
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 36.h,
                            decoration: BoxDecoration(
                                color: AppColors.black,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.sp, vertical: 10.sp),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalisation.coffeewithcrypto,
                                        style: AppTestStyle.headingBai(
                                          fontSize: 22.sp,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      AppIconsWidget.horizontaldiamond(
                                          color: AppColors.white, size: 15),
                                    ],
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Stack(
                                    children: [
                                      AppImages.dummyimage(),
                                      Positioned(
                                        bottom: 12.sp,
                                        right: 12.sp,
                                        child: CustomElevatedButton(
                                            backgroundcolor: AppColors.black,
                                            bordercolor: AppColors.black,
                                            fontsize: 16.sp,
                                            labelcolor: AppColors.white,
                                            onPressed: () {
                                              setState(() {
                                                showWatchedContent = true;
                                              });
                                            },
                                            text: 'Watch now'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Stack(
                          children: [
                            AppImages.dummyimage(
                                width: MediaQuery.of(context).size.width),
                            Positioned(
                              left: 10,
                              bottom: 20,
                              child: GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.info_outline,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            Positioned(
                                right: 0,
                                top: 30,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: AppIconsWidget.favourites()),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                showWatchedContent = false;
                                              });
                                            },
                                            child: AppIconsWidget.share()),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: AppIconsWidget.message()),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              AppIconsWidget.addtoplaylist()),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.sp, left: 15.sp),
                    child: Text(
                      AppLocalisation.cryptoBeans,
                      style: AppTestStyle.headingBai(
                        fontSize: 22.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 10.sp, left: 15.sp, bottom: 8.sp),
                    child: Text(
                      AppLocalisation.ashowabout,
                      style: AppTestStyle.headingint(
                        fontSize: 17.sp,
                        italic: true,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 18.sp, vertical: 15.sp),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: AppColors.black),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                !showQuizContent
                                    ? AppLocalisation.takethenextquiz
                                    : AppLocalisation.greatwork,
                                style: AppTestStyle.headingBai(
                                    color: Colors.purple,
                                    fontSize: 21.sp,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                !showQuizContent
                                    ? AppLocalisation
                                        .earnpointstoclaimexistingrewards
                                    : AppLocalisation.claimnextreward,
                                style: AppTestStyle.headingBai(
                                    color: AppColors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.purple)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.sp, vertical: 10.sp),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showQuizContent = !showQuizContent;
                                      });
                                    },
                                    child: Text(
                                        showQuizContent
                                            ? AppLocalisation.end
                                            : AppLocalisation.start,
                                        style: AppTestStyle.headingint(
                                            color: AppColors.white,
                                            fontSize: 16.sp)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  showQuizContent == false
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 18.sp),
                                child: Text(AppLocalisation.episodes,
                                    style: AppTestStyle.headingBai(
                                        fontSize: 26.sp))),
                            Padding(
                                padding: EdgeInsets.only(left: 15.sp),
                                child: HorizontalScrollableCard(
                                  textColor: AppColors.white,
                                  subtitle: AppLocalisation.episode1,
                                )),
                            Padding(
                                padding: EdgeInsets.only(left: 18.sp),
                                child: Text(AppLocalisation.events,
                                    style: AppTestStyle.headingBai(
                                        fontSize: 26.sp))),
                            Padding(
                              padding: EdgeInsets.only(left: 15.sp),
                              child: ScrollableElongatedCardWidget(
                                label: AppLocalisation.coffeesession,
                                sublabel: AppLocalisation.registernowex,
                                sublabel1: AppLocalisation.interactwithcreators,
                                onPressed: () {},
                              ),
                            ),
                            // Padding(
                            //     padding: EdgeInsets.only(left: 18.sp),
                            //     child: Text(AppLocalisation.events,
                            //         style: AppTestStyle.headingBai(
                            //             fontSize: 26.sp))),
                            // Padding(
                            //     padding: EdgeInsets.only(left: 15.sp),
                            //     child: HorizontalScrollableCard()),

                            Padding(
                              padding: EdgeInsets.only(left: 15.sp, top: 20.sp),
                              child: Text(
                                AppLocalisation.shareyourthoughts,
                                style: AppTestStyle.headingint(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.sp, 15.sp, 0, 10.sp),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: AppColors.black),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: AppLocalisation.ashwini,
                                            style: AppTestStyle.headingint(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w800,
                                                color: AppColors.white),
                                          ),
                                          TextSpan(
                                            text: AppLocalisation.sotrue,
                                            style: AppTestStyle.headingint(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.white),
                                          )
                                        ]),
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.sp, 15.sp, 0, 10.sp),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: AppColors.black),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: AppLocalisation.glo4life,
                                            style: AppTestStyle.headingint(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w800,
                                                color: AppColors.white),
                                          ),
                                          TextSpan(
                                            text: AppLocalisation
                                                .thanksforsharring,
                                            style: AppTestStyle.headingint(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.white),
                                          )
                                        ]),
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.sp, vertical: 15.sp),
                              child: Container(
                                height: 6.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: AppColors.black),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, // Adjust alignment
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: const TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Comment',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 6.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border:
                                            Border.all(color: AppColors.black),
                                        color:
                                            AppColors.black, // Background color
                                      ),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.sp),
                                          child: Center(
                                            child: Text(
                                              "Send",
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.sp),
                          child: showScoreContent
                              ? const ScoreWidget()
                              : Column(
                                  children: [
                                    QuizSection(
                                      number: AppLocalisation.queno,
                                      question: AppLocalisation.question,
                                      onNextPressed: () {
                                        setState(() {
                                          showScoreContent = true;
                                        });
                                      },
                                    ),
                                    GridView.count(
                                      childAspectRatio: 3,
                                      crossAxisCount: 2,
                                      shrinkWrap: true,
                                      children: const [
                                        GridQuestions(
                                            label:
                                                AppLocalisation.balancesheet),
                                        GridQuestions(
                                            label: AppLocalisation
                                                .incomestatement),
                                        GridQuestions(
                                            label: AppLocalisation
                                                .cashflowstatement),
                                        GridQuestions(
                                            label: AppLocalisation
                                                .statementofretained),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScoreWidget extends StatefulWidget {
  const ScoreWidget({super.key});

  @override
  State<ScoreWidget> createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Container(
            height: 30.h,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColors.black),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalisation.greatwork,
                      style: AppTestStyle.headingBai(
                          color: Colors.purple,
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalisation.claimnextreward,
                      style: AppTestStyle.headingBai(
                          color: AppColors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.purple)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.sp, vertical: 10.sp),
                        child: InkWell(
                          onTap: () {},
                          child: Text(AppLocalisation.finish,
                              style: AppTestStyle.headingint(
                                  color: AppColors.white, fontSize: 16.sp)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 12.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalisation.checkyourprogress,
                  style: AppTestStyle.headingint(
                      color: AppColors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600)),
              const Icon(Icons.arrow_forward, size: 30)
            ],
          ),
        )
      ],
    );
  }
}

class QuizSection extends StatefulWidget {
  final String number;
  final String question;
  final VoidCallback onNextPressed;
  const QuizSection({
    super.key,
    required this.number,
    required this.question,
    required this.onNextPressed,
  });

  @override
  State<QuizSection> createState() => _QuizSectionState();
}

class _QuizSectionState extends State<QuizSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.number,
              style: AppTestStyle.headingint(
                  color: AppColors.black,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w800),
            ),
            // const Spacer(),
            // TextButton(
            //   onPressed: widget.onNextPressed,
            //   child: Text(
            //     "Next",
            //     style: AppTestStyle.headingint(
            //         color: AppColors.black,
            //         fontSize: 21.sp,
            //         fontWeight: FontWeight.w800),
            //   ),
            // ),
          ],
        ),
        Text(
          widget.question,
          style: AppTestStyle.headingint(
              color: AppColors.black,
              fontSize: 21.sp,
              fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class RoundRadio extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const RoundRadio({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged!(!value);
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: value ? Colors.black : Colors.grey,
            width: 2.0,
          ),
        ),
        child: value
            ? Center(
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class GridQuestions extends StatefulWidget {
  final String label;
  const GridQuestions({
    super.key,
    required this.label,
  });

  @override
  State<GridQuestions> createState() => _GridQuestionsState();
}

class _GridQuestionsState extends State<GridQuestions> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundRadio(
          value: isSelected,
          onChanged: (newValue) {
            setState(() {
              isSelected = newValue!;
            });
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTestStyle.headingint(
                  color: AppColors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
    );
  }
}
