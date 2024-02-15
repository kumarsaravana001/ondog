import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ondgo_flutter/bloc/login_bloc/login_bloc.dart';
import 'package:ondgo_flutter/bloc/navigation_cubit/navigationbar_cubit.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showId_cubit.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
import 'package:ondgo_flutter/bloc/signin_bloc/signin_bloc.dart';
import 'package:ondgo_flutter/config/app_colors.dart';
import 'bloc/showscreen_bloc/quizVisibility_cubit.dart';
import 'bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_bloc.dart';
import 'utilities/index.dart';
import 'package:ondgo_flutter/view/screens/Signup/signup_screen.dart';
import 'package:ondgo_flutter/view/screens/search/search_library_screen.dart';
import '../view/view_index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('sessionBox');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  String initialRoute = determineInitialRoute();
  runApp(
      //DevicePreview(
      //builder: (context) => MyApp(
      //authToken: authToken,
      //),
      //));
      MyApp(initialRoute: initialRoute));
}

String determineInitialRoute() {
  var box = Hive.box('sessionBox');
  String? userId = box.get('userId');
  return userId != null ? '/navbar' : '/login';
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initialRoute = '/login';

  @override
  void initState() {
    super.initState();
    _checkUserSession();
  }

  void _checkUserSession() {
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');
    if (userId != null) {
      initialRoute = '/navbar';
    } else {
      initialRoute = '/signup';
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: widget.initialRoute,
      routes: [
        GoRoute(
            path: '/', builder: (context, state) => const SplashScreenone()),
        GoRoute(
            path: '/splash2',
            builder: (context, state) => const SplashScreentwo()),
        GoRoute(
            path: '/signup', builder: (context, state) => const SignupScreen()),
        GoRoute(
            path: '/login', builder: (context, state) => const LoginScreen()),
        GoRoute(path: '/navbar', builder: (context, state) => Navbar()),
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(
            path: '/showcase',
            builder: (context, state) => const ShowCaseScreen()),
        GoRoute(
            path: '/search',
            builder: (context, state) => const SearchandLibraryScreen()),
        GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen()),
        GoRoute(
            path: '/playlist',
            builder: (context, state) => const PlayListScreen()),
        GoRoute(
            path: '/events', builder: (context, state) => const EventsScreen()),
        GoRoute(
            path: '/purchase',
            builder: (context, state) => const PurchaseScreen()),
        GoRoute(
            path: '/rewards',
            builder: (context, state) => const RewardsScreen()),
        GoRoute(
            path: '/language',
            builder: (context, state) => const LanguageScreen()),
        GoRoute(path: '/help', builder: (context, state) => const HelpScreen()),
        GoRoute(
            path: '/feedback',
            builder: (context, state) => const FeedbackScreen()),
        GoRoute(
            path: '/contact',
            builder: (context, state) => const ContactUsScreen()),
        GoRoute(
            path: '/reels', builder: (context, state) => const ReelsScreen()),
        GoRoute(
            path: '/fullScreenImage',
            builder: (context, state) => const ReelsFullScreen()),
      ],
    );
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LoginBloc()),
            BlocProvider(create: (context) => SignInBloc()),
            BlocProvider(create: (context) => NavigationCubit()),
            BlocProvider(create: (context) => QuizVisibilityCubit()),
            BlocProvider(create: (context) => ShowIdCubit()),
            BlocProvider(create: (context) => EpisodeIdCubit()),
            BlocProvider(create: (context) => UserEpisodeDetailBloc()),
            BlocProvider(create: (context) => UserShowDetailBloc()),
            BlocProvider(create: (context) => ShowIdCubit()),
            BlocProvider(create: (context) => EpisodeIdCubit()),
            BlocProvider(create: (context) => QuizDetailsBloc()),
          ],
          child: MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            title: 'Ondgo',
            theme: ThemeData(
              useMaterial3: true,
              dialogBackgroundColor: AppColors.white,
            ),
          ),
        );
      },
    );
  }
}
