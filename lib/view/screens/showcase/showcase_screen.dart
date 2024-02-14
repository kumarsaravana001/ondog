import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_event.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_state.dart';
import 'package:ondgo_flutter/models/showscreen_modules/showscreen_modules.dart';
import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
import 'package:ondgo_flutter/view/screens/showcase/media_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/quiz_content.dart';
import 'package:ondgo_flutter/view/screens/showcase/quiz_question_answer_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/score_widget_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/show_case_card_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/watch_media_section.dart';
import '../../../bloc/showscreen_bloc/quizVisibility_cubit.dart';
import '../../../bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_bloc.dart';
import '../../../bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_event.dart';
import '../../../bloc/showscreen_bloc/showId_cubit.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_custombar.dart';

bool showWatchedContent = false;
bool showQuizContent = false;
bool showScoreContent = false;
int score = 0;

class ShowCaseScreen extends StatefulWidget {
  const ShowCaseScreen({super.key});

  @override
  State<ShowCaseScreen> createState() => _ShowCaseScreenState();
}

class _ShowCaseScreenState extends State<ShowCaseScreen> {


  int correctAnswers = 0;
  int currentQuestionIndex = 0;
  late int selectedOptionIndex = -1;
  int totalQuestions = 0;

  void handleOptionTap(int optionIndex) {
    setState(
      () {
        selectedOptionIndex = optionIndex;

        if (optionIndex ==
            quizData[currentQuestionIndex]['correctAnswerIndex']) {
          correctAnswers++;
        }

        if (currentQuestionIndex < quizData.length - 1) {
          currentQuestionIndex++;
          selectedOptionIndex = -1;
        } else {
          totalQuestions = quizData.length;
          showScoreContent = true;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => QuizVisibilityCubit()),
      ],
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<ShowIdCubit, int?>(
            listener: (context, showId) {
              if (showId != null) {
                context
                    .read<UserShowDetailBloc>()
                    .add(FetchUserShowDetail(showId: showId));
              }
            },
            child: Stack(
              children: [
                Positioned(
                    child: Center(
                        child: SvgPicture.asset(IconAssets.appbackground))),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.sp),
                          child: const CustomeAppBar()),
                      showWatchedContent == false
                          ? Padding(
                              padding: EdgeInsets.all(18.sp),
                              child: MediaSection(
                                onWatchNowPressed: () {
                                  setState(() {
                                    showWatchedContent = true;
                                  });
                                },
                              ),
                            )
                          : const MediaWatchSection(),
                      BlocBuilder<UserShowDetailBloc, UserShowDetailState>(
                        builder: (context, state) {
                          if (state is UserShowDetailLoading) {
                            return buildTextShimmerEffect();
                          } else if (state is UserShowDetailLoaded) {
                            final showDetails = state.userDetails.isNotEmpty
                                ? state.userDetails.first
                                : null;
                            return buildShowDetails(showDetails);
                          } else if (state is UserShowDetailError) {
                            return Text('Error: //${state.message}');
                          }
                          return const Text('Please select a show.');
                        },
                      ),
                      BlocBuilder<QuizVisibilityCubit, bool>(
                        builder: (context, showQuiz) {
                          return Visibility(
                            visible: showQuiz,
                            child: const QuizInitWIdget(),
                          );
                        },
                      ),
                      showQuizContent == false
                          ? const ShowCaseCardSections()
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.sp),
                              child: showScoreContent
                                  ? ScoreWidget(
                                      totalQuestions: totalQuestions,
                                      correctAnswers: correctAnswers,
                                      onFinishPressed: () {
                                        setState(() {
                                          showQuizContent = false;
                                        });
                                      },
                                    )
                                  : QuizQuestionAnswerSection(
                                      currentQuestionIndex:
                                          currentQuestionIndex,
                                      quizData: quizData,
                                      handleOptionTap: handleOptionTap)),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuizInitWIdget extends StatelessWidget {
  const QuizInitWIdget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 15.sp),
      child: Container(
        padding: EdgeInsets.all(15.sp),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: AppColors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // !showQuizContent
              //     ? AppLocalisation.takethenextquiz
              //     :
              AppLocalisation.greatwork,
              style: AppTestStyle.headingBai(
                  color: Colors.purple,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w800),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // !showQuizContent
                  //     ? AppLocalisation
                  //         .earnpointstoclaimexistingrewards
                  //     :
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
                    child: GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   showQuizContent = !showQuizContent;
                        // });
                      },
                      child: Text(
                          showQuizContent
                              ? AppLocalisation.end
                              : AppLocalisation.start,
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
    );
  }
}

Widget buildShowDetails(ShowDetailsData? showDetails) {
  if (showDetails == null) return const Text('No details available');
  return Padding(
    padding: EdgeInsets.only(top: 10.sp, left: 18.sp),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          showDetails.showName ?? 'Show Name Not Available',
          style: AppTestStyle.headingBai(
            fontSize: 22.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.sp),
          child: Text(
            showDetails.description ?? 'Description Not Available',
            style: AppTestStyle.headingint(
              fontSize: 17.sp,
              italic: true,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

class QuizQuestionAnswerSection extends StatefulWidget {
  const QuizQuestionAnswerSection({
    super.key,
    required this.currentQuestionIndex,
    required this.quizData,
    required this.handleOptionTap,
  });

  final int currentQuestionIndex;
  final Function(int) handleOptionTap;
  final List<Map<String, dynamic>> quizData;

  @override
  State<QuizQuestionAnswerSection> createState() =>
      _QuizQuestionAnswerSectionState();
}

class _QuizQuestionAnswerSectionState extends State<QuizQuestionAnswerSection> {
  late int _selectedOptionIndex = -1;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentQuestion =
        widget.quizData[widget.currentQuestionIndex];
    List<String> options = currentQuestion['options'];

    return Column(
      children: [
        QuizQuestionSection(
          number: '${widget.currentQuestionIndex + 1} / 10 ',
          question: currentQuestion['question'],
        ),
        GridView.count(
          childAspectRatio: 3,
          crossAxisCount: 2,
          shrinkWrap: true,
          children: List.generate(
            options.length,
            (index) => RadioListTile<int>(
              activeColor: AppColors.black,
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(options[index]),
              value: index,
              groupValue: _selectedOptionIndex,
              onChanged: (int? value) {
                if (value != null) {
                  widget.handleOptionTap(value);
                  setState(() {
                    _selectedOptionIndex = value;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
