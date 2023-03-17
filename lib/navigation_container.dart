import 'package:flutter/material.dart';

import 'package:skitmaker/views/screens/skits/download_page.dart';
import 'package:skitmaker/views/screens/skits/quicky_page.dart';
import 'package:skitmaker/views/screens/skits/skit_home_page.dart';
import 'package:skitmaker/views/screens/skits/trendy_page.dart';
import 'package:skitmaker/views/widgets/bottom_navigation_bar.dart';

class NavigationContainer extends StatefulWidget {
  const NavigationContainer({super.key});

  @override
  State<NavigationContainer> createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer> {
  int _selectedPageIndex = 0;
  static final List<Widget> _pages = [
    SkitHomePage(),
    TrendyPage(),
    const Text(''),
    QuickyPage(),
    const DownloadPage(),
  ];

  void _onIconTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedPageIndex],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedPageIndex: _selectedPageIndex,
        onIconTap: _onIconTapped,
      ),
    );
  }
}
