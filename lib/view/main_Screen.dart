// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:news_app/view/Category/categories.dart';
// import 'package:news_app/view/home_screen.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   @override
//   Widget build(BuildContext context) {
//     int _currentIndex = 0;

//     final List<Widget> _tabs = [
//       HomeScreen(),
//       Categories(),
//     ];

//     return Scaffold(
//       body: _tabs[_currentIndex],
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: Colors.transparent,
//         color: Colors.black,
//         index: _currentIndex,
//         items: const <Widget>[
//           Icon(Icons.newspaper, size: 30, color: Colors.white),
//           Icon(Icons.person_2_outlined, size: 30, color: Colors.white),
//         ],
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
