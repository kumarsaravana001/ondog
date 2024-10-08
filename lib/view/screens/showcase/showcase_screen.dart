// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeVideoDetails_bloc/epidoseVideoDetail_state.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_state.dart';
// import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
// import 'package:ondgo_flutter/view/screens/showcase/media_cover_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/qna_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/quiz_init_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/score_widget_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/showcase_cards_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/video_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/widgets.dart';
// import '../../../bloc/showscreen_bloc/episodeVideoDetails_bloc/epidoseVideoDetail_bloc.dart';
// import '../../../bloc/showscreen_bloc/episodeVideoDetails_bloc/episodeVideoDetail_event.dart';
// import '../../../bloc/showscreen_bloc/quizDetails_bloc/quizdetail_bloc.dart';
// import '../../../bloc/showscreen_bloc/quizVisibility_cubit.dart';
// import '../../../bloc/showscreen_bloc/showId_cubit.dart';
// import '../../../config/config_index.dart';
// import '../../../utilities/app_custombar.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_event.dart';

// class ShowCaseScreen extends StatefulWidget {
//   const ShowCaseScreen({super.key});

//   @override
//   State<ShowCaseScreen> createState() => _ShowCaseScreenState();
// }

// class _ShowCaseScreenState extends State<ShowCaseScreen> {
//   int correctAnswers = 0;
//   int totalQuestions = 0;
//   bool showQuizContent = false;
//   bool showScoreContent = false;

//   // int currentQuestionIndex = 0;
//   // int selectedOptionIndex = -1;
//   bool showWatchedContent = false;
//   int selectedEpisodeId = -1;

//   @override
//   void initState() {
//     super.initState();

//     final showId = context.read<ShowIdCubit>().state;
//     final episodeId = context.read<EpisodeIdCubit>().state;
//     if (showId > 0 && episodeId > 0) {
//       context
//           .read<QuizDetailsBloc>()
//           .add(FetchQuizDetails(showId: showId, episodeId: episodeId));
//     }
//   }

//   void _handleWatchNowPressed() {
//     setState(() {
//       showWatchedContent = true;
//     });
//   }

//   void _handleStartQuiz() {
//     final showId = context.read<ShowIdCubit>().state;
//     final episodeId = context.read<EpisodeIdCubit>().state;
//     setState(() {
//       selectedEpisodeId = episodeId;
//       showWatchedContent = false;
//     });

//     context
//         .read<VideoDetailsBloc>()
//         .add(FetchVideoDetails(showId: showId, episodeId: episodeId));
//     // final showId = context.read<ShowIdCubit>().state;
//     // final episodeId = context.read<EpisodeIdCubit>().state;
//     // if (showId > 0 && episodeId > 0) {
//     //   context
//     //       .read<QuizDetailsBloc>()
//     //       .add(FetchQuizDetails(showId: showId, episodeId: episodeId));
//     // }

//     // setState(() {
//     //   showQuizContent = true;
//     // });
//   }

//   void _handleEndQuiz() {
//     const Center(child: Text("Quiz Ended"));
//     setState(() {
//       showQuizContent = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final showId = context.read<ShowIdCubit>().state;
//     final episodeId = context.read<EpisodeIdCubit>().state;
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<QuizDetailsBloc>(
//             create: (context) => QuizDetailsBloc()
//               ..add(FetchQuizDetails(showId: showId, episodeId: episodeId))),
//         BlocProvider<VideoDetailsBloc>(create: (context) => VideoDetailsBloc()
//             // ..add(FetchVideoDetails(showId: showId, episodeId: episodeId)),
//             ),
//         BlocProvider(create: (_) => QuizVisibilityCubit()),
//       ],
//       child: Scaffold(
//         body: SafeArea(
//           child: BlocListener<EpisodeIdCubit, int?>(
//             listener: (context, episodeId) {
//               if (episodeId != null) {
//                 setState(() {
//                   showWatchedContent = false;
//                 });
//                 // context
//                 //     .read<UserShowDetailBloc>()
//                 //     .add(FetchUserShowDetail(showId: showId));
//               }
//             },
//             child: Stack(
//               children: [
//                 // Positioned(
//                 //   child: Center(
//                 //     child: SvgPicture.asset(IconAssets.appbackground),
//                 //   ),
//                 // ),
//                 SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const CustomeAppBar(),
//                       showWatchedContent == false
//                           ? Padding(
//                               padding: EdgeInsets.all(18.sp),
//                               child: MediaCoverSection(
//                                 onWatchNowPressed: () {
//                                   setState(() {
//                                     showWatchedContent = true;
//                                   });
//                                 },
//                               ),
//                             )
//                           : BlocBuilder<UserShowDetailBloc,
//                               UserShowDetailState>(
//                               builder: (context, state) {
//                                 if (state is UserShowDetailLoaded) {
//                                   final showDetails =
//                                       state.userDetails.isNotEmpty
//                                           ? state.userDetails.first
//                                           : null;
//                                   if (showDetails != null) {
//                                     return MediaWatchSection(
//                                       videoUrl: showDetails.showTeaser ??
//                                           'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//                                     );
//                                   }
//                                 }
//                                 return const Center(
//                                     child: Text("Video Not playing"));
//                               },
//                             ),
//                       // if (!showWatchedContent)
//                       //   Padding(
//                       //     padding: EdgeInsets.all(18.sp),
//                       //     child: MediaCoverSection(
//                       //       onWatchNowPressed: _handleWatchNowPressed,
//                       //       selectedEpisodeId: selectedEpisodeId,
//                       //     ),
//                       //   )
//                       // else
//                       //   BlocBuilder<VideoDetailsBloc, VideoDetailsState>(
//                       //     builder: (context, state) {
//                       //       if (state is VideoDetailsLoaded &&
//                       //           state.episodevideoDetails.isNotEmpty) {
//                       //         final videoDetail =
//                       //             state.episodevideoDetails.first;
//                       //         return MediaWatchSection(
//                       //           videoUrl: videoDetail.url ?? '',
//                       //           onVideoStopped: () {
//                       //             setState(() {
//                       //               showWatchedContent = false;
//                       //             });
//                       //           },
//                       //         );
//                       //       }
//                       //       return const Center(
//                       //           child: Text("Video Not playing"));
//                       //     },
//                       //   ),
//                       BlocBuilder<UserShowDetailBloc, UserShowDetailState>(
//                         builder: (context, state) {
//                           if (state is UserShowDetailLoading) {
//                             return buildTextShimmerEffect();
//                           } else if (state is UserShowDetailLoaded) {
//                             final showDetails = state.userDetails.isNotEmpty
//                                 ? state.userDetails.first
//                                 : null;
//                             return buildShowDetails(showDetails, context);
//                           } else if (state is UserShowDetailError) {
//                             return Center(
//                                 child: Text('Error: ${state.message}'));
//                           }
//                           return const Center(
//                               child: Text('Please select a show.'));
//                         },
//                       ),
//                       BlocBuilder<QuizVisibilityCubit, bool>(
//                           builder: (context, showQuiz) {
//                         return Visibility(
//                           visible: showQuiz,
//                           child: QuizInitWIdget(
//                             onStartQuiz: _handleStartQuiz,
//                             onEndQuiz: _handleEndQuiz,
//                           ),
//                         );
//                       }),
//                       if (showQuizContent)
//                         BlocBuilder<QuizVisibilityCubit, bool>(
//                           builder: (context, showQuiz) {
//                             return Visibility(
//                               visible: showQuiz,
//                               child: Padding(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 20.sp),
//                                 child: showScoreContent
//                                     ? ScoreWidget(
//                                         totalQuestions: totalQuestions,
//                                         correctAnswers: correctAnswers,
//                                         onFinishPressed: () {
//                                           setState(() {
//                                             showQuizContent = false;
//                                           });
//                                         })
//                                     : const QuizQuestionAnswerSection(),
//                               ),
//                             );
//                           },
//                         ),
//                       const ShowCaseCardSections(),
//                       SizedBox(height: 10.h),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeVideoDetails_bloc/epidoseVideoDetail_state.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_state.dart';
// import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
// import 'package:ondgo_flutter/view/screens/showcase/media_cover_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/qna_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/quiz_init_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/score_widget_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/showcase_cards_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/video_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/widgets.dart';
// import '../../../bloc/showscreen_bloc/episodeVideoDetails_bloc/epidoseVideoDetail_bloc.dart';
// import '../../../bloc/showscreen_bloc/episodeVideoDetails_bloc/episodeVideoDetail_event.dart';
// import '../../../bloc/showscreen_bloc/quizDetails_bloc/quizdetail_bloc.dart';
// import '../../../bloc/showscreen_bloc/quizVisibility_cubit.dart';
// import '../../../bloc/showscreen_bloc/showId_cubit.dart';
// import '../../../config/config_index.dart';
// import '../../../utilities/app_custombar.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_event.dart';

// class ShowCaseScreen extends StatefulWidget {
//   const ShowCaseScreen({super.key});

//   @override
//   State<ShowCaseScreen> createState() => _ShowCaseScreenState();
// }

// class _ShowCaseScreenState extends State<ShowCaseScreen>
//     with WidgetsBindingObserver {
//   int correctAnswers = 0;
//   int totalQuestions = 0;
//   bool showQuizContent = false;
//   bool showScoreContent = false;
//   bool showWatchedContent = false;
//   int selectedEpisodeId = -1;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);

//     final showId = context.read<ShowIdCubit>().state;
//     final episodeId = context.read<EpisodeIdCubit>().state;
//     if (showId > 0 && episodeId > 0) {
//       context
//           .read<QuizDetailsBloc>()
//           .add(FetchQuizDetails(showId: showId, episodeId: episodeId));
//     }
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused ||
//         state == AppLifecycleState.inactive) {
//       setState(() {
//         showWatchedContent = false;
//       });
//     }
//   }

//   void _handleWatchNowPressed() {
//     setState(() {
//       showWatchedContent = true;
//     });
//   }

//   void _handleEpisodeSelected(int episodeId) {
//     setState(() {
//       selectedEpisodeId = episodeId;
//       showWatchedContent = false;
//     });

//     final showId = context.read<ShowIdCubit>().state;
//     context
//         .read<VideoDetailsBloc>()
//         .add(FetchVideoDetails(showId: showId, episodeId: episodeId));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final showId = context.read<ShowIdCubit>().state;
//     final episodeId = context.read<EpisodeIdCubit>().state;
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<QuizDetailsBloc>(
//             create: (context) => QuizDetailsBloc()
//               ..add(FetchQuizDetails(showId: showId, episodeId: episodeId))),
//         BlocProvider<VideoDetailsBloc>(create: (context) => VideoDetailsBloc()),
//         BlocProvider(create: (_) => QuizVisibilityCubit()),
//       ],
//       child: Scaffold(
//         body: SafeArea(
//           child: BlocListener<EpisodeIdCubit, int?>(
//             listener: (context, episodeId) {
//               if (episodeId != null) {
//                 setState(() {
//                   showWatchedContent = false;
//                 });
//               }
//             },
//             child: Stack(
//               children: [
//                 SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const CustomeAppBar(),
//                       if (!showWatchedContent)
//                         Padding(
//                           padding: EdgeInsets.all(18.sp),
//                           child: MediaCoverSection(
//                             onWatchNowPressed: _handleWatchNowPressed,
//                             selectedEpisodeId: selectedEpisodeId,
//                           ),
//                         )
//                       else
//                         BlocBuilder<VideoDetailsBloc, VideoDetailsState>(
//                           builder: (context, state) {
//                             if (state is VideoDetailsLoaded &&
//                                 state.episodevideoDetails.isNotEmpty) {
//                               final videoDetail =
//                                   state.episodevideoDetails.first;
//                               return MediaWatchSection(
//                                 videoUrl: videoDetail.url ?? '',
//                                 onVideoStopped: () {
//                                   setState(() {
//                                     showWatchedContent = false;
//                                   });
//                                 },
//                               );
//                             }
//                             return const Center(
//                                 child: Text("Video Not playing"));
//                           },
//                         ),
//                       BlocBuilder<UserShowDetailBloc, UserShowDetailState>(
//                         builder: (context, state) {
//                           if (state is UserShowDetailLoading) {
//                             return buildTextShimmerEffect();
//                           } else if (state is UserShowDetailLoaded) {
//                             final showDetails = state.userDetails.isNotEmpty
//                                 ? state.userDetails.first
//                                 : null;
//                             return buildShowDetails(showDetails, context);
//                           } else if (state is UserShowDetailError) {
//                             return Center(
//                                 child: Text('Error: ${state.message}'));
//                           }
//                           return const Center(
//                               child: Text('Please select a show.'));
//                         },
//                       ),
//                       const ShowCaseCardSections(
//                           // onEpisodeSelected: _handleEpisodeSelected,
//                           ),
//                       SizedBox(height: 10.h),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeVideoDetails_bloc/epidoseVideoDetail_bloc.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeVideoDetails_bloc/epidoseVideoDetail_state.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeVideoDetails_bloc/episodeVideoDetail_event.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_event.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_state.dart';
// import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
// import 'package:ondgo_flutter/view/screens/showcase/media_cover_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/showcase_cards_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/video_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/widgets.dart';
// import '../../../bloc/showscreen_bloc/quizDetails_bloc/quizdetail_bloc.dart';
// import '../../../bloc/showscreen_bloc/quizVisibility_cubit.dart';
// import '../../../bloc/showscreen_bloc/showId_cubit.dart';
// import '../../../config/config_index.dart';
// import '../../../utilities/app_custombar.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_event.dart';

// class ShowCaseScreen extends StatefulWidget {
//   const ShowCaseScreen({super.key});

//   @override
//   State<ShowCaseScreen> createState() => _ShowCaseScreenState();
// }

// class _ShowCaseScreenState extends State<ShowCaseScreen>
//     with WidgetsBindingObserver {
//   int correctAnswers = 0;
//   int totalQuestions = 0;
//   bool showQuizContent = false;
//   bool showScoreContent = false;
//   bool showWatchedContent = false;
//   bool showMediaCover = true;
//   int selectedEpisodeId = -1;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);

//     final showId = context.read<ShowIdCubit>().state;
//     final episodeId = context.read<EpisodeIdCubit>().state;
//     if (showId > 0 && episodeId > 0) {
//       context
//           .read<QuizDetailsBloc>()
//           .add(FetchQuizDetails(showId: showId, episodeId: episodeId));
//     }
//     setState(() {
//       showMediaCover = true;
//       showWatchedContent = false;
//       selectedEpisodeId = -1;
//     });

//     context.read<UserShowDetailBloc>().add(FetchUserShowDetail(showId: showId));
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused ||
//         state == AppLifecycleState.inactive) {
//       setState(() {
//         showWatchedContent = false;
//       });
//     }
//   }

//   void _handleWatchNowPressed() {
//     setState(() {
//       showWatchedContent = true;
//       showMediaCover = false;
//     });

//     final showId = context.read<ShowIdCubit>().state;

//     if (selectedEpisodeId > 0) {
//       // If an episode is selected, fetch the episode video details
//       context
//           .read<VideoDetailsBloc>()
//           .add(FetchVideoDetails(showId: showId, episodeId: selectedEpisodeId));
//     } else {
//       // If no episode is selected, fetch the teaser video details
//       context
//           .read<UserShowDetailBloc>()
//           .add(FetchUserShowDetail(showId: showId));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final showId = context.read<ShowIdCubit>().state;
//     final episodeId = context.read<EpisodeIdCubit>().state;
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<QuizDetailsBloc>(
//             create: (context) => QuizDetailsBloc()
//               ..add(FetchQuizDetails(showId: showId, episodeId: episodeId))),
//         BlocProvider<VideoDetailsBloc>(create: (context) => VideoDetailsBloc()),
//         BlocProvider(create: (_) => QuizVisibilityCubit()),
//       ],
//       child: Scaffold(
//         body: SafeArea(
//           child: BlocListener<EpisodeIdCubit, int?>(
//             listener: (context, episodeId) {
//               if (episodeId != null) {
//                 setState(() {
//                   showWatchedContent = false;
//                 });
//               }
//             },
//             child: Stack(
//               children: [
//                 SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const CustomeAppBar(),
//                       if (showMediaCover)
//                         Padding(
//                           padding: EdgeInsets.all(18.sp),
//                           child: MediaCoverSection(
//                             onWatchNowPressed: _handleWatchNowPressed,
//                             selectedEpisodeId: selectedEpisodeId,
//                           ),
//                         )
//                       else if (showWatchedContent)
//                         BlocBuilder<VideoDetailsBloc, VideoDetailsState>(
//                           builder: (context, state) {
//                             if (state is VideoDetailsLoaded &&
//                                 state.episodevideoDetails.isNotEmpty) {
//                               final videoDetail =
//                                   state.episodevideoDetails.first;
//                               return MediaWatchSection(
//                                 videoUrl: videoDetail.url ?? '',
//                                 onVideoStopped: () {
//                                   setState(() {
//                                     showWatchedContent = false;
//                                     showMediaCover = true;
//                                   });
//                                 },
//                               );
//                             }
//                             return const Center(
//                                 child: Text("Video Not playing"));
//                           },
//                         )
//                       else
//                         const Center(
//                           child: Text("Select an episode to watch"),
//                         ),
//                       BlocBuilder<UserShowDetailBloc, UserShowDetailState>(
//                         builder: (context, state) {
//                           if (state is UserShowDetailLoading) {
//                             return buildTextShimmerEffect();
//                           } else if (state is UserShowDetailLoaded) {
//                             final showDetails = state.userDetails.isNotEmpty
//                                 ? state.userDetails.first
//                                 : null;
//                             return buildShowDetails(showDetails, context);
//                           } else if (state is UserShowDetailError) {
//                             return Center(
//                                 child: Text('Error: ${state.message}'));
//                           }
//                           return const Center(
//                               child: Text('Please select a show.'));
//                         },
//                       ),
//                       const ShowCaseCardSections(),
//                       SizedBox(height: 10.h),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeDisplay_cubit.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeVideoDetails_bloc/epidoseVideoDetail_bloc.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeVideoDetails_bloc/epidoseVideoDetail_state.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeVideoDetails_bloc/episodeVideoDetail_event.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_state.dart';
// import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
// import 'package:ondgo_flutter/view/screens/showcase/media_cover_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/qna_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/quiz_init_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/score_widget_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/showcase_cards_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/video_section.dart';
// import 'package:ondgo_flutter/view/screens/showcase/widgets.dart';
// import '../../../bloc/showscreen_bloc/quizDetails_bloc/quizdetail_bloc.dart';
// import '../../../bloc/showscreen_bloc/quizVisibility_cubit.dart';
// import '../../../bloc/showscreen_bloc/showId_cubit.dart';
// import '../../../config/config_index.dart';
// import '../../../utilities/app_custombar.dart';
// import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_event.dart';

// class ShowCaseScreen extends StatefulWidget {
//   const ShowCaseScreen({super.key});

//   @override
//   State<ShowCaseScreen> createState() => _ShowCaseScreenState();
// }

// class _ShowCaseScreenState extends State<ShowCaseScreen>
//     with WidgetsBindingObserver {
//   int correctAnswers = 0;
//   int totalQuestions = 0;
//   bool showQuizContent = false;
//   bool showScoreContent = false;
//   bool showWatchedContent = false;
//   bool showMediaCover = true;
//   int selectedEpisodeId = -1;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     context.read<DisplayCubit>().showUserDetails();
//     final showId = context.read<ShowIdCubit>().state;
//     final episodeId = context.read<EpisodeIdCubit>().state;
//     if (showId > 0 && episodeId > 0) {
//       context
//           .read<QuizDetailsBloc>()
//           .add(FetchQuizDetails(showId: showId, episodeId: episodeId));
//     }

//     setState(() {
//       showMediaCover = true;
//       showWatchedContent = false;
//       selectedEpisodeId = -1;
//     });

//     // context.read<UserShowDetailBloc>().add(FetchUserShowDetail(showId: showId));
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);

//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused ||
//         state == AppLifecycleState.inactive) {
//       setState(() {
//         showWatchedContent = false;
//       });
//     }
//   }

//   void _handleWatchNowPressed() {
//     setState(() {
//       showWatchedContent = true;
//       showMediaCover = false;
//     });
//   }

//   void _handleStartQuiz() {
//     final showId = context.read<ShowIdCubit>().state;
//     final episodeId = context.read<EpisodeIdCubit>().state;
//     print('Start Quiz ${showId}');
//     print('Start Quiz ${episodeId}');
//     setState(() {
//       selectedEpisodeId = episodeId;
//       showWatchedContent = false;
//       showQuizContent = true;
//     });

//     // context
//     //     .read<VideoDetailsBloc>()
//     //     .add(FetchVideoDetails(showId: showId, episodeId: episodeId));

//     if (showId > 0 && episodeId > 0) {
//       context
//           .read<QuizDetailsBloc>()
//           .add(FetchQuizDetails(showId: showId, episodeId: episodeId));
//     }

//     // setState(() {
//     //   showQuizContent = true;
//     // });
//   }

//   void _handleEndQuiz() {
//     const Center(child: Text("Quiz Ended"));
//     setState(() {
//       showQuizContent = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final showId = context.read<ShowIdCubit>().state;
//     final episodeId = context.read<EpisodeIdCubit>().state;
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<QuizDetailsBloc>(
//             create: (context) => QuizDetailsBloc()
//               ..add(FetchQuizDetails(showId: showId, episodeId: episodeId))),
//         BlocProvider<VideoDetailsBloc>(create: (context) => VideoDetailsBloc()),
//         BlocProvider(create: (_) => QuizVisibilityCubit()),
//       ],
//       child: Scaffold(
//         body: SafeArea(
//           child: BlocListener<EpisodeIdCubit, int?>(
//             listener: (context, episodeId) {
//               if (episodeId != null) {
//                 setState(() {
//                   showWatchedContent = false;
//                 });
//                 context.read<DisplayCubit>().showUserDetails();
//               }
//             },
//             child: Stack(
//               children: [
//                 SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const CustomeAppBar(),
//                       if (showMediaCover)
//                         Padding(
//                           padding: EdgeInsets.all(18.sp),
//                           child: MediaCoverSection(
//                             onWatchNowPressed: _handleWatchNowPressed,
//                             //selectedEpisodeId: selectedEpisodeId,
//                           ),
//                         )
//                       else if (showWatchedContent)
//                         BlocBuilder<VideoDetailsBloc, VideoDetailsState>(
//                           builder: (context, state) {
//                             if (state is VideoDetailsLoaded &&
//                                 state.episodevideoDetails.isNotEmpty) {
//                               final videoDetail =
//                                   state.episodevideoDetails.first;
//                               return MediaWatchSection(
//                                 videoUrl: videoDetail.url ?? '',
//                                 onVideoStopped: () {
//                                   setState(() {
//                                     showWatchedContent = false;
//                                     showMediaCover = true;
//                                   });
//                                 },
//                               );
//                             }
//                             return BlocBuilder<UserShowDetailBloc,
//                                 UserShowDetailState>(
//                               builder: (context, state) {
//                                 if (state is UserShowDetailLoaded) {
//                                   final showDetails =
//                                       state.userDetails.isNotEmpty
//                                           ? state.userDetails.first
//                                           : null;
//                                   if (showDetails != null) {
//                                     return MediaWatchSection(
//                                       onVideoStopped: () {
//                                         setState(() {
//                                           showWatchedContent = false;
//                                           showMediaCover = true;
//                                         });
//                                       },
//                                       videoUrl: showDetails.showTeaser ??
//                                           'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//                                     );
//                                   }
//                                 }
//                                 return const Center(
//                                     child: CircularProgressIndicator());
//                               },
//                             );

//                             // const Center(
//                             //     child: CircularProgressIndicator());
//                           },
//                         )
//                       else
//                         const Center(
//                           child: Text("Select an episode to watch"),
//                         ),
//                       BlocBuilder<UserShowDetailBloc, UserShowDetailState>(
//                         builder: (context, state) {
//                           if (state is UserShowDetailLoading) {
//                             return buildTextShimmerEffect();
//                           } else if (state is UserShowDetailLoaded) {
//                             final showDetails = state.userDetails.isNotEmpty
//                                 ? state.userDetails.first
//                                 : null;
//                             return buildShowDetails(showDetails, context);
//                           } else if (state is UserShowDetailError) {
//                             return Center(
//                                 child: Text('Error: ${state.message}'));
//                           }
//                           return const Center(
//                               child: Text('Please select a show.'));
//                         },
//                       ),
//                       BlocBuilder<QuizVisibilityCubit, bool>(
//                           builder: (context, showQuiz) {
//                         return Visibility(
//                           visible: showQuiz,
//                           child: QuizInitWIdget(
//                             onStartQuiz: _handleStartQuiz,
//                             onEndQuiz: _handleEndQuiz,
//                           ),
//                         );
//                       }),
//                       if (showQuizContent)
//                         BlocBuilder<QuizVisibilityCubit, bool>(
//                           builder: (context, showQuiz) {
//                             return Visibility(
//                               visible: showQuiz,
//                               child: Padding(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 20.sp),
//                                 child: showScoreContent
//                                     ? ScoreWidget(
//                                         totalQuestions: totalQuestions,
//                                         correctAnswers: correctAnswers,
//                                         onFinishPressed: () {
//                                           setState(() {
//                                             showQuizContent = false;
//                                           });
//                                         })
//                                     : const QuizQuestionAnswerSection(),
//                               ),
//                             );
//                           },
//                         ),
//                       const ShowCaseCardSections(),
//                       SizedBox(height: 10.h),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeDisplay_cubit.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeVideoDetails_bloc/epidoseVideoDetail_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeVideoDetails_bloc/epidoseVideoDetail_state.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeVideoDetails_bloc/episodeVideoDetail_event.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_state.dart';
import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
import 'package:ondgo_flutter/view/screens/showcase/media_cover_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/qna_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/quiz_init_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/score_widget_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/showcase_cards_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/video_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/widgets.dart';
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

class _ShowCaseScreenState extends State<ShowCaseScreen>
    with WidgetsBindingObserver {
  int correctAnswers = 0;
  int totalQuestions = 0;
  bool showQuizContent = false;
  bool showScoreContent = false;
  bool showWatchedContent = false;
  bool showMediaCover = true;
  int selectedEpisodeId = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<DisplayCubit>().showUserDetails();
    final showId = context.read<ShowIdCubit>().state;
    final episodeId = context.read<EpisodeIdCubit>().state;
    if (showId > 0 && episodeId > 0) {
      context
          .read<QuizDetailsBloc>()
          .add(FetchQuizDetails(showId: showId, episodeId: episodeId));
    }

    setState(() {
      showMediaCover = true;
      showWatchedContent = false;
      selectedEpisodeId = -1;
    });

    // context.read<UserShowDetailBloc>().add(FetchUserShowDetail(showId: showId));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      setState(() {
        showWatchedContent = false;
      });
    }
  }

  void _handleWatchNowPressed() {
    setState(() {
      showWatchedContent = true;
      showMediaCover = false;
    });
  }

  void _handleStartQuiz() {
    final showId = context.read<ShowIdCubit>().state;
    final episodeId = context.read<EpisodeIdCubit>().state;
    print('Start Quiz ${showId}');
    print('Start Quiz ${episodeId}');
    setState(() {
      selectedEpisodeId = episodeId;
      showWatchedContent = false;
      showQuizContent = true;
    });

    // context
    //     .read<VideoDetailsBloc>()
    //     .add(FetchVideoDetails(showId: showId, episodeId: episodeId));

    if (showId > 0 && episodeId > 0) {
      context
          .read<QuizDetailsBloc>()
          .add(FetchQuizDetails(showId: showId, episodeId: episodeId));
    }

    // setState(() {
    //   showQuizContent = true;
    // });
  }

  void _handleEndQuiz() {
    const Center(child: Text("Quiz Ended"));
    setState(() {
      showQuizContent = false;
    });
  }

  void _handleQuizCompleted() {
    setState(() {
      showQuizContent = false;
      showScoreContent = true;
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
        BlocProvider<VideoDetailsBloc>(create: (context) => VideoDetailsBloc()),
        BlocProvider(create: (_) => QuizVisibilityCubit()),
      ],
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<EpisodeIdCubit, int?>(
            listener: (context, episodeId) {
              if (episodeId != null) {
                setState(() {
                  showWatchedContent = false;
                });
                context.read<DisplayCubit>().showUserDetails();
              }
            },
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomeAppBar(),
                      if (showMediaCover)
                        Padding(
                          padding: EdgeInsets.all(18.sp),
                          child: MediaCoverSection(
                            onWatchNowPressed: _handleWatchNowPressed,
                            //selectedEpisodeId: selectedEpisodeId,
                          ),
                        )
                      else if (showWatchedContent)
                        BlocBuilder<VideoDetailsBloc, VideoDetailsState>(
                          builder: (context, state) {
                            if (state is VideoDetailsLoaded &&
                                state.episodevideoDetails.isNotEmpty) {
                              final videoDetail =
                                  state.episodevideoDetails.first;
                              return MediaWatchSection(
                                videoUrl: videoDetail.url ?? '',
                                onVideoStopped: () {
                                  setState(() {
                                    showWatchedContent = false;
                                    showMediaCover = true;
                                  });
                                },
                              );
                            }
                            return BlocBuilder<UserShowDetailBloc,
                                UserShowDetailState>(
                              builder: (context, state) {
                                if (state is UserShowDetailLoaded) {
                                  final showDetails =
                                      state.userDetails.isNotEmpty
                                          ? state.userDetails.first
                                          : null;
                                  if (showDetails != null) {
                                    return MediaWatchSection(
                                      onVideoStopped: () {
                                        setState(() {
                                          showWatchedContent = false;
                                          showMediaCover = true;
                                        });
                                      },
                                      videoUrl: showDetails.showTeaser ??
                                          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                                    );
                                  }
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            );

                            // const Center(
                            //     child: CircularProgressIndicator());
                          },
                        )
                      else
                        const Center(
                          child: Text("Select an episode to watch"),
                        ),
                      BlocBuilder<UserShowDetailBloc, UserShowDetailState>(
                        builder: (context, state) {
                          if (state is UserShowDetailLoading) {
                            return buildTextShimmerEffect();
                          } else if (state is UserShowDetailLoaded) {
                            final showDetails = state.userDetails.isNotEmpty
                                ? state.userDetails.first
                                : null;
                            return buildShowDetails(showDetails, context);
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
                                child: QuizQuestionAnswerSection(
                                  onQuizCompleted: _handleQuizCompleted,
                                ),
                              ),
                            );
                          },
                        ),
                      if (showScoreContent)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.sp),
                          child: ScoreWidget(
                            totalQuestions: totalQuestions,
                            correctAnswers: correctAnswers,
                            onFinishPressed: () {
                              setState(() {
                                showScoreContent = false;
                              });
                            },
                          ),
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
