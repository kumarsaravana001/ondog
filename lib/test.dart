// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:ondgo_flutter/view/view_index.dart';

// import '../../../config/config_index.dart';

// class Navbardemo extends StatefulWidget {
//   const Navbardemo({super.key});

//   @override
//   State<Navbardemo> createState() => _NavbardemoState();
// }

// class _NavbardemoState extends State<Navbardemo> {
//   int _selectedIndex = 0;
//   final List<Widget> _pages = [
//     const ProfileScreen(),
//     const ProfileScreen(),
//     const ProfileScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     int _selectedIndex = 0;
//     final List<Widget> _pages = [
//       const HomeScreen(),
//       const ProfileScreen(),
//       const HomeScreen(),
//     ];

//     void _onItemTapped(int index) {
//       setState(() {
//         _selectedIndex = index;
//       });
//     }

//     return Scaffold(
//         body: Stack(
//       children: [
//         Positioned(
//           left: 50,
//           right: 50,
//           bottom: 0,
//           child: Container(
//             decoration: const BoxDecoration(
//                 color: Colors.amber,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20))),
//             height: 80,
//             width: MediaQuery.of(context).size.width,
//             child: BottomNavigationBar(
//               backgroundColor: AppColors.black,
//               type: BottomNavigationBarType.fixed,
//               items: <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(IconAssets.navbaricon1, height: 25),
//                   label: '',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(IconAssets.navbaricon2, height: 25),
//                   label: '',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(IconAssets.navbaricon3, height: 25),
//                   label: '',
//                 ),
//               ],
//               currentIndex: _selectedIndex,
//               selectedFontSize: 0,
//               unselectedFontSize: 0,
//               onTap: _onItemTapped,
//             ),
//           ),
//         ),
//       ],
//     )
//         //  _pages[_selectedIndex],
//         // bottomNavigationBar: Padding(
//         //     padding: const EdgeInsets.all(8.0),
//         //     child: Stack(
//         //       children: [
//         //         Positioned(
//         //           bottom: 0,
//         //           child: Container(
//         //             height: 100,
//         //             width: 100,
//         //             color: Colors.amber,
//         //             child: Text("data"),
//         //           ),
//         //         )
//         //       ],
//         //     )

//         //  BottomNavigationBar(
//         //   backgroundColor: AppColors.black,
//         //   type: BottomNavigationBarType.fixed,
//         //   items: <BottomNavigationBarItem>[
//         //     BottomNavigationBarItem(
//         //       icon: SvgPicture.asset(IconAssets.navbaricon1, height: 25),
//         //       label: '',
//         //     ),
//         //     BottomNavigationBarItem(
//         //       icon: SvgPicture.asset(IconAssets.navbaricon2, height: 25),
//         //       label: '',
//         //     ),
//         //     BottomNavigationBarItem(
//         //       icon: SvgPicture.asset(IconAssets.navbaricon3, height: 25),
//         //       label: '',
//         //     ),
//         //   ],
//         //   currentIndex: _selectedIndex,
//         //   selectedFontSize: 0,
//         //   unselectedFontSize: 0,
//         //   onTap: _onItemTapped,
//         // ),
//         );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:ondgo_flutter/view/view_index.dart';

// import '../../../config/config_index.dart';

// class Navbardemo extends StatefulWidget {
//   const Navbardemo({Key? key}) : super(key: key);

//   @override
//   State<Navbardemo> createState() => _NavbardemoState();
// }

// class _NavbardemoState extends State<Navbardemo> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: IndexedStack(
//               index: _selectedIndex,
//               children: const [
//                 HomeScreen(),
//                 ProfileScreen(),
//                 HomeScreen(),
//               ],
//             ),
//           ),
//           Positioned(
//             left: 50,
//             right: 50,
//             bottom: 0,
//             child: Container(
//               decoration: const BoxDecoration(
//                 color: Colors.amber,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               height: 80,
//               width: MediaQuery.of(context).size.width - 100,
//               child: BottomNavigationBar(
//                 backgroundColor: AppColors.black,
//                 type: BottomNavigationBarType.fixed,
//                 items: <BottomNavigationBarItem>[
//                   BottomNavigationBarItem(
//                     icon: SvgPicture.asset(IconAssets.navbaricon1, height: 25),
//                     label: '',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: SvgPicture.asset(IconAssets.navbaricon2, height: 25),
//                     label: '',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: SvgPicture.asset(IconAssets.navbaricon3, height: 25),
//                     label: '',
//                   ),
//                 ],
//                 currentIndex: _selectedIndex,
//                 selectedFontSize: 0,
//                 unselectedFontSize: 0,
//                 onTap: _onItemTapped,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
