import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ondgo_flutter/config/app_colors.dart';
import 'package:ondgo_flutter/config/app_icons.dart';
import 'package:ondgo_flutter/view/screens/profile/profile_screen.dart';
import 'package:ondgo_flutter/bloc/navigation_cubit/navigationbar_cubit.dart';
import 'package:ondgo_flutter/view/screens/reels/reels_screen.dart';
import '../view/screens/homescreen/home.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final List<BottomNavigationBarItem> _navBarItems = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(IconAssets.navbaricon1, height: 25),
      label: '',
    ),

    BottomNavigationBarItem(
      icon: SvgPicture.asset(IconAssets.navbaricon2, height: 25),
      label: '',
    ),

    BottomNavigationBarItem(
      icon: SvgPicture.asset(IconAssets.badgecloseblack, height: 48),
      label: '',
    ),

    // BottomNavigationBarItem(
    //   icon: SvgPicture.asset(IconAssets.navbaricon3, height: 25),
    //   label: '',
    // ),

    // BottomNavigationBarItem(
    //   icon: SvgPicture.asset(IconAssets.horizontaldiamond,
    //       height: 20, color: AppColors.white),
    //   label: '',
    // ),
  ];

  final List<Widget> _screens = [
    const HomeScreen(),
    const ReelsScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    final NavigationCubit navigationCubit =
        BlocProvider.of<NavigationCubit>(context);
    if (navigationCubit.state != 0) {
      navigationCubit.navigateToIndex(0);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, int>(
        builder: (context, selectedIndex) {
          return Stack(
            children: [
              Positioned.fill(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    const begin = Offset(0.0, 1.0); // Start from the bottom
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;

                    var slideTween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var fadeTween = Tween(begin: 0.0, end: 1.0); // For fading

                    return FadeTransition(
                      opacity: animation.drive(fadeTween),
                      child: SlideTransition(
                        position: animation.drive(slideTween),
                        child: child,
                      ),
                    );
                  },
                  child: IndexedStack(
                    index: selectedIndex,
                    children: _screens,
                  ),
                ),
              ),
              Positioned(
                left: 15,
                right: 15,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: BottomNavigationBar(
                    backgroundColor: AppColors.black,
                    type: BottomNavigationBarType.fixed,
                    items: _navBarItems,
                    currentIndex: selectedIndex,
                    selectedFontSize: 0,
                    unselectedFontSize: 0,
                    onTap: (index) => BlocProvider.of<NavigationCubit>(context)
                        .navigateToIndex(index),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
