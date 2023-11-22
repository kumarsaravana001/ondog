import 'package:flutter/material.dart';
import 'package:ondgo_flutter/view/view_index.dart';
import '../../../config/config_index.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: IndexedStack(
              index: _selectedIndex,
              children: const [
                HomeScreen(),
                ShowCaseScreen(),
                ProfileScreen(),
                //  ReelsScreen()
              ],
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
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(IconAssets.navbaricon1, height: 25),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(IconAssets.navbaricon2, height: 25),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(IconAssets.navbaricon3, height: 25),
                    label: '',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedFontSize: 0,
                unselectedFontSize: 0,
                onTap: _onItemTapped,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class NavBar extends StatefulWidget {
//   const NavBar({super.key});

//   @override
//   State<NavBar> createState() => _NavBarState();
// }

// class _NavBarState extends State<NavBar> {
//   int _selectedIndex = 0;
//   final List<Widget> _pages = [
//     const HomeScreen(),
//     const ProfileScreen(),
//     const HomeScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           child: BottomNavigationBar(
//             backgroundColor: AppColors.black,
//             type: BottomNavigationBarType.fixed,
//             items: <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: SvgPicture.asset(IconAssets.navbaricon1, height: 25),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: SvgPicture.asset(IconAssets.navbaricon2, height: 25),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: SvgPicture.asset(IconAssets.navbaricon3, height: 25),
//                 label: '',
//               ),
//             ],
//             currentIndex: _selectedIndex,
//             selectedFontSize: 0,
//             unselectedFontSize: 0,
//             onTap: _onItemTapped,
//           ),
//         ),
//       ),
//     );
//   }
// }
