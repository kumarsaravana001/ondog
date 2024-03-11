// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ondgo_flutter/bloc/navigation_cubit/navbar_cubit.dart';
// import 'package:ondgo_flutter/view/screens/search/search_library_screen.dart';
// import 'package:ondgo_flutter/view/view_index.dart';
// import '../../../config/config_index.dart';

// class Navbar extends StatefulWidget {
//   const Navbar({Key? key}) : super(key: key);

//   @override
//   State<Navbar> createState() => _NavbarState();
// }

// class _NavbarState extends State<Navbar> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<NavigationCubit>(
//         create: (_) => NavigationCubit(),
//         child: Scaffold(
//           body: Stack(
//             children: [
//               Positioned.fill(
//                 child: IndexedStack(
//                   index: _selectedIndex,
//                   children: const [
//                     HomeScreen(),
//                     SearchandLibraryScreen(),
//                     ReelsScreen(),
//                     ShowCaseScreen(),
//                     ProfileScreen(),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 left: 15,
//                 right: 15,
//                 bottom: 0,
//                 child: ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                   child: BottomNavigationBar(
//                     backgroundColor: AppColors.black,
//                     type: BottomNavigationBarType.fixed,
//                     items: <BottomNavigationBarItem>[
//                       BottomNavigationBarItem(
//                         icon: SvgPicture.asset(IconAssets.navbaricon1,
//                             height: 25),
//                         label: '',
//                       ),
//                       BottomNavigationBarItem(
//                         icon: SvgPicture.asset(
//                           IconAssets.horizontaldiamond,
//                           height: 20,
//                           color: AppColors.white,
//                         ),
//                         label: '',
//                       ),
//                       BottomNavigationBarItem(
//                         icon: SvgPicture.asset(IconAssets.navbaricon2,
//                             height: 25),
//                         label: '',
//                       ),
//                       BottomNavigationBarItem(
//                         icon: SvgPicture.asset(IconAssets.navbaricon3,
//                             height: 25),
//                         label: '',
//                       ),
//                       BottomNavigationBarItem(
//                         icon: SvgPicture.asset(IconAssets.badgecloseblack,
//                             height: 48),
//                         label: '',
//                       ),
//                     ],
//                     currentIndex: _selectedIndex,
//                     selectedFontSize: 0,
//                     unselectedFontSize: 0,
//                     onTap: _onItemTapped,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ondgo_flutter/config/app_colors.dart';
import 'package:ondgo_flutter/config/app_icons.dart';
import 'package:ondgo_flutter/view/screens/profile/profile_screen.dart';
import 'package:ondgo_flutter/view/screens/reels/reels_full_screen.dart';
import 'package:ondgo_flutter/view/screens/reels/reels_screen.dart';
import 'package:ondgo_flutter/view/screens/search/search_library_screen.dart';
import 'package:ondgo_flutter/view/screens/showcase/showcase_screen.dart';
import 'package:ondgo_flutter/bloc/navigation_cubit/navigationbar_cubit.dart';

import '../view/screens/homescreen/home.dart';

class Navbar extends StatelessWidget {
  Navbar({Key? key}) : super(key: key);

  final List<Widget> _screens = [
    HomeScreen(),
    ShowCaseScreen(),
    // ReelsScreen(),
    ProfileScreen(),
    // SearchandLibraryScreen(),
    // ReelsScreen(),
    // ReelsFullScreen(),
    // ShortsPage(),
    // ShowCaseScreen(),
  ];

  final List<BottomNavigationBarItem> _navBarItems = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(IconAssets.navbaricon1, height: 25),
      label: '',
    ),
    // BottomNavigationBarItem(
    //   icon: SvgPicture.asset(IconAssets.horizontaldiamond,
    //       height: 20, color: AppColors.white),
    //   label: '',
    // ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(IconAssets.navbaricon2, height: 25),
      label: '',
    ),
    // BottomNavigationBarItem(
    //   icon: SvgPicture.asset(IconAssets.navbaricon3, height: 25),
    //   label: '',
    // ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(IconAssets.badgecloseblack, height: 48),
      label: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final NavigationCubit navCubit =
            BlocProvider.of<NavigationCubit>(context);
        final int currentIndex = navCubit.state;

        if (currentIndex != 0) {
          navCubit.navigateToIndex(0);
          return false;
        }

        return true;
      },
      child: Scaffold(
        body: BlocBuilder<NavigationCubit, int>(
          builder: (context, selectedIndex) {
            return Stack(
              children: [
                IndexedStack(
                  index: selectedIndex,
                  children: _screens,
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
                      onTap: (index) =>
                          BlocProvider.of<NavigationCubit>(context)
                              .navigateToIndex(index),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
