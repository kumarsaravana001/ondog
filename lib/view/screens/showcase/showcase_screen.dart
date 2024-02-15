import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_event.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_state.dart';
import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
import 'package:ondgo_flutter/view/screens/showcase/media_cover_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/qna_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/quiz_content.dart';
import 'package:ondgo_flutter/view/screens/showcase/quiz_init_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/score_widget_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/showcase_cards_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/video_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/widgets.dart';
import '../../../bloc/showscreen_bloc/quizDetails_bloc/quizdetail_bloc.dart';
import '../../../bloc/showscreen_bloc/quizVisibility_cubit.dart';
import '../../../bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_bloc.dart';
import '../../../bloc/showscreen_bloc/showId_cubit.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_custombar.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_event.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_state.dart';

class ShowCaseScreen extends StatefulWidget {
  const ShowCaseScreen({super.key});

  @override
  State<ShowCaseScreen> createState() => _ShowCaseScreenState();
}

class _ShowCaseScreenState extends State<ShowCaseScreen> {
  int correctAnswers = 0;
  int currentQuestionIndex = 0;
  int selectedOptionIndex = -1;
  int totalQuestions = 0;
  bool showWatchedContent = false;
  bool showQuizContent = false;
  bool showScoreContent = false;

  // void handleOptionTap(int optionIndex) {
  //   setState(
  //     () {
  //       selectedOptionIndex = optionIndex;

  //       if (optionIndex ==
  //           quizData[currentQuestionIndex]['correctAnswerIndex']) {
  //         correctAnswers++;
  //       }

  //       if (currentQuestionIndex < quizData.length - 1) {
  //         currentQuestionIndex++;
  //         selectedOptionIndex = -1;
  //       } else {
  //         totalQuestions = quizData.length;
  //         showScoreContent = true;
  //       }
  //     },
  //   );
  // }
  @override
  void initState() {
    super.initState();
    // Listen to changes in showId and episodeId and fetch quiz details accordingly
    final showId = context.read<ShowIdCubit>().state;
    final episodeId = context.read<EpisodeIdCubit>().state;
    if (showId > 0 && episodeId > 0) {
      context
          .read<QuizDetailsBloc>()
          .add(FetchQuizDetails(showId: showId, episodeId: episodeId));
    }
  }

  void _handleStartQuiz() {
    final showId = context.read<ShowIdCubit>().state;
    final episodeId = context.read<EpisodeIdCubit>().state;
    if (showId > 0 && episodeId > 0) {
      context
          .read<QuizDetailsBloc>()
          .add(FetchQuizDetails(showId: showId, episodeId: episodeId));
    }

    setState(() {
      showQuizContent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final showId = context.read<ShowIdCubit>().state;
    final episodeId = context.read<EpisodeIdCubit>().state;
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuizDetailsBloc>(
            create: (context) => QuizDetailsBloc()
              ..add(FetchQuizDetails(showId: showId, episodeId: episodeId))),
        BlocProvider(create: (_) => QuizVisibilityCubit()),
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
                            return Text('Error: ////${state.message}');
                          }
                          return const Text('Please select a show.');
                        },
                      ),
                      BlocBuilder<QuizVisibilityCubit, bool>(
                          builder: (context, showQuiz) {
                        return Visibility(
                          visible: showQuiz,
                          child: QuizInitWIdget(onStartQuiz: _handleStartQuiz),
                        );
                      }),
                      if (showQuizContent)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.sp),
                          child: showScoreContent
                              ? ScoreWidget(
                                  totalQuestions: totalQuestions,
                                  correctAnswers: correctAnswers,
                                  onFinishPressed: () {
                                    setState(() {
                                      showQuizContent = false;
                                    });
                                  })
                              : const QuizQuestionAnswerSection(),
                        ),
                      const ShowCaseCardSections(),
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
