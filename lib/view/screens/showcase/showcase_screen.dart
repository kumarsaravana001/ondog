import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_event.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_state.dart';
import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
import 'package:ondgo_flutter/view/screens/showcase/media_cover_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/qna_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/quiz_init_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/score_widget_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/showcase_cards_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/video_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/widgets.dart';
import '../../../bloc/showscreen_bloc/episodeDetails_bloc/epidoseVideoDetail_bloc.dart';
import '../../../bloc/showscreen_bloc/episodeDetails_bloc/episodeVideoDetail_event.dart';
import '../../../bloc/showscreen_bloc/quizDetails_bloc/quizdetail_bloc.dart';
import '../../../bloc/showscreen_bloc/quizVisibility_cubit.dart';
import '../../../bloc/showscreen_bloc/showId_cubit.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_custombar.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_event.dart';

class ShowCaseScreen extends StatefulWidget {
  const ShowCaseScreen({super.key});

  @override
  State<ShowCaseScreen> createState() => _ShowCaseScreenState();
}

class _ShowCaseScreenState extends State<ShowCaseScreen> {
  int correctAnswers = 0;
  int currentQuestionIndex = 0;
  int selectedOptionIndex = -1;
  bool showQuizContent = false;
  bool showScoreContent = false;
  bool showWatchedContent = false;
  int totalQuestions = 0;

  @override
  void initState() {
    super.initState();

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

  void _handleEndQuiz() {
    const Center(child: Text("Quiz Ended"));
    setState(() {
      showQuizContent = false;
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
        BlocProvider<VideoDetailsBloc>(
            create: (context) => VideoDetailsBloc()
              ..add(FetchVideoDetails(showId: showId, episodeId: episodeId))),
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
                    child: SvgPicture.asset(IconAssets.appbackground),
                  ),
                ),
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
                              child: MediaCoverSection(
                                onWatchNowPressed: () {
                                  setState(() {
                                    showWatchedContent = true;
                                  });
                                },
                              ),
                            )
                          : BlocBuilder<UserShowDetailBloc,
                              UserShowDetailState>(
                              builder: (context, state) {
                                if (state is UserShowDetailLoaded) {
                                  final showDetails =
                                      state.userDetails.isNotEmpty
                                          ? state.userDetails.first
                                          : null;
                                  if (showDetails != null) {
                                    return MediaWatchSection(
                                      videoUrl: showDetails.showTeaser ??
                                          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                                    );
                                  }
                                }
                                return const Center(
                                    child: Text("Video Not playing"));
                              },
                            ),
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
                            return Center(
                                child: Text('Error: ${state.message}'));
                          }
                          return const Center(
                              child: Text('Please select a show.'));
                        },
                      ),
                      BlocBuilder<QuizVisibilityCubit, bool>(
                          builder: (context, showQuiz) {
                        return Visibility(
                          visible: showQuiz,
                          child: QuizInitWIdget(
                            onStartQuiz: _handleStartQuiz,
                            onEndQuiz: _handleEndQuiz,
                          ),
                        );
                      }),
                      if (showQuizContent)
                        BlocBuilder<QuizVisibilityCubit, bool>(
                          builder: (context, showQuiz) {
                            return Visibility(
                              visible: showQuiz,
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 20.sp),
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
                            );
                          },
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
