// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ondgo_flutter/bloc/login_bloc/login_bloc.dart';
import 'package:ondgo_flutter/bloc/navigation_cubit/navigationbar_cubit.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/feedback_bloc/feedback_bloc.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/purchase_bloc/purchase_bloc.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/rewards_bloc/rewards_bloc.dart';
import 'package:ondgo_flutter/bloc/search_bloc/catwiseshow_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/episodeVideoDetails_bloc/epidoseVideoDetail_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showId_cubit.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
import 'package:ondgo_flutter/bloc/signin_bloc/signin_bloc.dart';
import 'package:ondgo_flutter/config/app_colors.dart';
import 'package:ondgo_flutter/view/screens/Signup/otpverify_screen.dart';
import 'package:ondgo_flutter/view/screens/forgetpassword/forgetpassword_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'bloc/reels_bloc/reels_bloc.dart';
import 'bloc/search_bloc/search_bloc.dart';
import 'bloc/showscreen_bloc/episodeDisplay_cubit.dart';
import 'bloc/showscreen_bloc/quizVisibility_cubit.dart';
import 'bloc/showscreen_bloc/showEpisodeDetails_bloc/showEpisode_details_bloc.dart';
import 'utilities/index.dart';
import 'package:ondgo_flutter/view/screens/Signup/signup_screen.dart';
import 'package:ondgo_flutter/view/screens/search/search_library_screen.dart';
import '../view/view_index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ffjcllaaepufvjcskdpy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZmamNsbGFhZXB1ZnZqY3NrZHB5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTk4MTg5NjQsImV4cCI6MjAzNTM5NDk2NH0.VfCxoD918q22kFLavj1NHDQH9YiuVw4pEOjBTOdjjFA',
  );
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  await Hive.openBox('sessionBox');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  String initialRoute = determineInitialRoute();

  runApp(
    MyApp(initialRoute: initialRoute),
  );
}

String determineInitialRoute() {
  var box = Hive.box('sessionBox');
  String? userId = box.get('userId');
  return userId != null ? Routes.navbar : Routes.login;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initialRoute});
  final String initialRoute;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initialRoute = Routes.login;

  @override
  void initState() {
    super.initState();
    _checkUserSession();
  }

  void _checkUserSession() {
    var box = Hive.box('sessionBox');
    String? userId = box.get('userId');
    if (userId != null) {
      initialRoute = Routes.navbar;
    } else {
      initialRoute = Routes.signup;
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: Routes.splashIntro,
      // initialLocation: '/splashIntro',
      // routes: [
      //   GoRoute(
      //       path: '/', builder: (context, state) => const SplashScreenone()),
      //   GoRoute(
      //       path: '/splash2',
      //       builder: (context, state) => const SplashScreentwo()),
      //   GoRoute(
      //       path: '/splashIntro',
      //       builder: (context, state) => const SplashScreenIntro()),
      //   GoRoute(
      //       path: '/signup', builder: (context, state) => const SignupScreen()),
      //   GoRoute(
      //       path: '/login', builder: (context, state) => const LoginScreen()),
      //   GoRoute(
      //       path: '/forgetpassword',
      //       builder: (context, state) => const ForgetPasswordScreen()),
      //   GoRoute(path: '/navbar', builder: (context, state) => const Navbar()),
      //   GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      //   GoRoute(
      //       path: '/showcase',
      //       builder: (context, state) => const ShowCaseScreen()),
      //   GoRoute(
      //       path: '/search',
      //       builder: (context, state) => const SearchandLibraryScreen()),
      //   GoRoute(
      //       path: '/profile',
      //       builder: (context, state) => const ProfileScreen()),
      //   GoRoute(
      //       path: '/playlist',
      //       builder: (context, state) => const PlayListScreen()),
      //   GoRoute(
      //       path: '/events', builder: (context, state) => const EventsScreen()),
      //   GoRoute(
      //       path: '/purchase',
      //       builder: (context, state) => const PurchaseScreen()),
      //   GoRoute(
      //       path: '/rewards',
      //       builder: (context, state) => const RewardsScreen()),
      //   GoRoute(
      //       path: '/language',
      //       builder: (context, state) => const LanguageScreen()),
      //   GoRoute(path: '/help', builder: (context, state) => const HelpScreen()),
      //   GoRoute(
      //       path: '/feedback',
      //       builder: (context, state) => const FeedbackScreen()),
      //   GoRoute(
      //       path: '/contact',
      //       builder: (context, state) => const ContactUsScreen()),
      //   GoRoute(
      //       path: '/reels', builder: (context, state) => const ReelsScreen()),
      //   GoRoute(
      //       path: '/fullScreenImage',
      //       builder: (context, state) => const ShortsPage()),
      // ],
      routes: [
        GoRoute(
            path: Routes.splashOne,
            builder: (context, state) => const SplashScreenone()),
        GoRoute(
            path: Routes.splashTwo,
            builder: (context, state) => const SplashScreentwo()),
        GoRoute(
            path: Routes.splashIntro,
            builder: (context, state) => const SplashScreenIntro()),
        GoRoute(
            path: Routes.signup,
            builder: (context, state) => const SignupScreen()),
        GoRoute(
            path: Routes.login,
            builder: (context, state) => const LoginScreen()),
        GoRoute(
            path: Routes.forgetPassword,
            builder: (context, state) => const ForgetPasswordScreen()),
        GoRoute(
            path: Routes.navbar, builder: (context, state) => const Navbar()),
        GoRoute(
            path: Routes.home, builder: (context, state) => const HomeScreen()),
        GoRoute(
            path: Routes.showcase,
            builder: (context, state) => const ShowCaseScreen()),
        GoRoute(
            path: Routes.search,
            builder: (context, state) => const SearchandLibraryScreen()),
        GoRoute(
            path: Routes.profile,
            builder: (context, state) => const ProfileScreen()),
        GoRoute(
            path: Routes.playlist,
            builder: (context, state) => const PlayListScreen()),
        GoRoute(
            path: Routes.events,
            builder: (context, state) => const EventsScreen()),
        GoRoute(
            path: Routes.purchase,
            builder: (context, state) => const PurchaseScreen()),
        GoRoute(
            path: Routes.rewards,
            builder: (context, state) => const RewardsScreen()),
        GoRoute(
            path: Routes.language,
            builder: (context, state) => const LanguageScreen()),
        GoRoute(
            path: Routes.help, builder: (context, state) => const HelpScreen()),
        GoRoute(
            path: Routes.feedback,
            builder: (context, state) => const FeedbackScreen()),
        GoRoute(
            path: Routes.contact,
            builder: (context, state) => const ContactUsScreen()),
        GoRoute(
            path: Routes.reels,
            builder: (context, state) => const ReelsScreen()),
        GoRoute(
            path: Routes.fullScreenImage,
            builder: (context, state) => const ShortsPage()),
        // GoRoute(
        //     path: Routes.otpVerification,
        //     builder: (context, state) => OtpVerificationScreen()),
        GoRoute(
          path: '/otpVerification',
          builder: (context, state) {
            final phoneNumber = state.extra as Map<String, String>?;
            return OtpVerificationScreen(
              phoneNumber: phoneNumber?['phoneNumber'] ?? '',
            );
          },
        ),
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
            BlocProvider(create: (context) => VideoDetailsBloc()),
            BlocProvider(create: (context) => UserEpisodeDetailBloc()),
            BlocProvider(create: (context) => CategoryWiseShowSearchBloc()),
            BlocProvider(create: (context) => DisplayCubit()),
            BlocProvider(create: (context) => UserShowDetailBloc()),
            BlocProvider(create: (context) => ShowIdCubit()),
            BlocProvider(create: (context) => EpisodeIdCubit()),
            BlocProvider(create: (context) => QuizDetailsBloc()),
            BlocProvider(create: (context) => SearchBloc()),
            BlocProvider(create: (context) => UserReelsBloc()),
            BlocProvider(create: (context) => FeedbackBloc()),
            BlocProvider(create: (context) => PurchaseBloc()),
            BlocProvider(create: (context) => RewardsBloc()),
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

class Routes {
  static const String splashIntro = '/splashIntro';
  static const String splashOne = '/';
  static const String splashTwo = '/splash2';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String forgetPassword = '/forgetpassword';
  static const String navbar = '/navbar';
  static const String home = '/home';
  static const String showcase = '/showcase';
  static const String search = '/search';
  static const String profile = '/profile';
  static const String playlist = '/playlist';
  static const String events = '/events';
  static const String purchase = '/purchase';
  static const String rewards = '/rewards';
  static const String language = '/language';
  static const String help = '/help';
  static const String feedback = '/feedback';
  static const String contact = '/contact';
  static const String reels = '/reels';
  static const String fullScreenImage = '/fullScreenImage';
  static const String otpVerification = '/OtpVerificationScreen';
}
