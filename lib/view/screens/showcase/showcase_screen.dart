import 'package:flutter/material.dart';
import 'package:ondgo_flutter/view/screens/showcase/media_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/quiz_question_answer_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/score_widget_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/show_case_card_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/watch_media_section.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_custombar.dart';

bool showWatchedContent = false;
bool showQuizContent = false;
bool showScoreContent = false;

class ShowCaseScreen extends StatefulWidget {
  const ShowCaseScreen({super.key});

  @override
  State<ShowCaseScreen> createState() => _ShowCaseScreenState();
}

class _ShowCaseScreenState extends State<ShowCaseScreen> {
  int currentQuestionIndex = 0;
  List<Map<String, dynamic>> quizData = [
    {
      'question':
          'What financial statement lists assets from current to long term?',
      'options': [
        'Balance sheet',
        'Income Statement',
        'Cashflow statement',
        'Statement of retainer earnings'
      ],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'What financial statement lists ?',
      'options': [
        'Statement of retainer earnings',
        'Balance sheet',
        'Income Statement',
        'Cashflow statement',
      ],
      'correctAnswerIndex': 1,
    },
    {
      'question': 'What  lists ?',
      'options': [
        'Income Statement',
        'Cashflow statement',
        'Statement of retainer earnings',
        'Balance sheet',
      ],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'What  lists ?',
      'options': [
        'Income Statement',
        'Cashflow statement',
        'Statement of retainer earnings',
        'Balance sheet',
      ],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'What  lists ?',
      'options': [
        'Income Statement',
        'Cashflow statement',
        'Statement of retainer earnings',
        'Balance sheet',
      ],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'What  lists ?',
      'options': [
        'Income Statement',
        'Cashflow statement',
        'Statement of retainer earnings',
        'Balance sheet',
      ],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'What  lists ?',
      'options': [
        'Income Statement',
        'Cashflow statement',
        'Statement of retainer earnings',
        'Balance sheet',
      ],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'What  lists ?',
      'options': [
        'Income Statement',
        'Cashflow statement',
        'Statement of retainer earnings',
        'Balance sheet',
      ],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'What  lists ?',
      'options': [
        'Income Statement',
        'Cashflow statement',
        'Statement of retainer earnings',
        'Balance sheet',
      ],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'What  lists ?',
      'options': [
        'Income Statement',
        'Cashflow statement',
        'Statement of retainer earnings',
        'Balance sheet',
      ],
      'correctAnswerIndex': 2,
    },
  ];
  void handleOptionTap(int optionIndex) {
    if (optionIndex == quizData[currentQuestionIndex]['correctAnswerIndex']) {
      if (currentQuestionIndex < quizData.length - 1) {
        setState(() {
          currentQuestionIndex++;
        });
      } else {
        setState(() {
          showScoreContent = true;
        });
      }
    } else {
      // Handle incorrect answer logic if needed
    }
  }

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
                    child: const CustomeAppBar(),
                  ),
                  showWatchedContent == false
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MediaSection(
                            onWatchNowPressed: () {
                              setState(() {
                                showWatchedContent = true;
                              });
                            },
                          ))
                      : const MediaWatchSection(),
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
                          Text(
                            !showQuizContent
                                ? AppLocalisation.takethenextquiz
                                : AppLocalisation.greatwork,
                            style: AppTestStyle.headingBai(
                                color: Colors.purple,
                                fontSize: 21.sp,
                                fontWeight: FontWeight.w800),
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
                      ? const ShowCaseCardSections()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.sp),
                          child: showScoreContent
                              ? const ScoreWidget()
                              : QuizQuestionAnswerSection(
                                  currentQuestionIndex: currentQuestionIndex,
                                  quizData: quizData,
                                  handleOptionTap: handleOptionTap,
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

class QuizQuestionAnswerSection extends StatelessWidget {
  final int currentQuestionIndex;
  final List<Map<String, dynamic>> quizData;
  final Function(int) handleOptionTap;

  const QuizQuestionAnswerSection({
    super.key,
    required this.currentQuestionIndex,
    required this.quizData,
    required this.handleOptionTap,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentQuestion = quizData[currentQuestionIndex];
    List<String> options = currentQuestion['options'];

    return Column(
      children: [
        QuizQuestionSection(
          number: '${currentQuestionIndex + 1} / 10 ',
          question: currentQuestion['question'],
        ),
        GridView.count(
          childAspectRatio: 3,
          crossAxisCount: 2,
          shrinkWrap: true,
          children: List.generate(
            options.length,
            (index) => GestureDetector(
              onTap: () => handleOptionTap(index),
              child: GridQuestions(
                label: options[index],
                onSelectionChanged: (isSelected) {
                  if (isSelected) {
                    handleOptionTap(index);
                  }
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
