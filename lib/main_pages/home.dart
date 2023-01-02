import 'package:flutter/material.dart';
import 'package:wuxialist/main_pages/library.dart';
import 'package:wuxialist/main_pages/profile.dart';
import 'package:wuxialist/main_pages/search.dart';
import 'package:wuxialist/main_pages/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  final screens = const [
    LibraryPage(),
    SearchPage(),
    ProfilePage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentPage, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index) => setState(() => currentPage = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Library",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
