import 'package:go_router/go_router.dart';
import 'package:ondgo_flutter/test.dart';
import 'package:ondgo_flutter/utilities/index.dart';
import 'package:ondgo_flutter/view/screens/search/search_library_screen.dart';
import '../view/view_index.dart';

// todo Routs and subrouts to be implemented
final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreenone()),
    GoRoute(
        path: '/splash2', builder: (context, state) => const SplashScreentwo()),
    GoRoute(path: '/signup', builder: (context, state) => const SignUpScreen()),
    GoRoute(path: '/Navbar', builder: (context, state) => const Navbar()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
        path: '/showcase', builder: (context, state) => const ShowCaseScreen()),
    GoRoute(
        path: '/search',
        builder: (context, state) => const SearchandLibraryScreen()),
    GoRoute(
        path: '/profile', builder: (context, state) => const ProfileScreen()),
    GoRoute(
        path: '/playlist', builder: (context, state) => const PlayListScreen()),
    GoRoute(path: '/events', builder: (context, state) => const EventsScreen()),
    GoRoute(
        path: '/purchase', builder: (context, state) => const PurchaseScreen()),
    GoRoute(
        path: '/rewards', builder: (context, state) => const RewardsScreen()),
    GoRoute(
        path: '/language', builder: (context, state) => const LanguageScreen()),
    GoRoute(path: '/help', builder: (context, state) => const HelpScreen()),
    GoRoute(
        path: '/feedback', builder: (context, state) => const FeedbackScreen()),
    GoRoute(
        path: '/contact', builder: (context, state) => const ContactUsScreen()),
    GoRoute(path: '/reels', builder: (context, state) => const ReelsScreen()),
    GoRoute(
        path: '/fullScreenImage',
        builder: (context, state) => const ReelsFullScreen()),
    // GoRoute(path: '/test', builder: (context, state) => const TestScreen()),
  ],
);

class RouteNames {
  static const splashscreen1 = "splashscreen1";
  static const splashscreen2 = "splashscreen2";
  static const signupscreen = "signupscreen";
  static const profilescreen = "profilescreen";
  static const homescreen = "homescreen";
  static const playlistcreen = "playlistcreen";
  static const eventsscreen = "eventsscreen";
  static const purchasecreen = "purchasecreen";
  static const rewardsscreen = "rewardsscreen";
  static const languagescreen = "languagescreen";
  static const helpscreen = "helpscreen";
  static const feedbackscreen = "feedbackscreen";
  static const contactscreen = "contactscreen";
}
