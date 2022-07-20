import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/screen/clickup_tasklist_screen.dart';
import 'package:mo_opendata_v2/screen/dashboard_screen.dart';
import 'package:mo_opendata_v2/screen/home_screen.dart';
import 'package:mo_opendata_v2/screen/wa_number_validator.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 2;

  @override
  Widget build(BuildContext context) {
    Widget bodyContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return const HomeScreen();
        case 1:
          return const TaskList();
        case 2:
          return const DashboardScreen();
        case 3:
          return const NumberCheck();
        default:
          return const HomeScreen();
      }
    }

    Widget customBottomNav(BuildContext context) {
      return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                color: index == 0 ? Colors.blue : Colors.grey,
                size: 30,
              ),
              label: '',
              tooltip: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.task_alt_rounded,
                color: index == 1 ? Colors.blue : Colors.grey,
                size: 30,
              ),
              label: '',
              tooltip: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: index == 2 ? Colors.blue : Colors.grey,
                size: 30,
              ),
              label: '',
              tooltip: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.checklist,
                color: index == 3 ? Colors.blue : Colors.grey,
                size: 30,
              ),
              label: '',
              tooltip: 'Contacts',
            ),
          ],
        ),
      );
    }

    return Scaffold(
      bottomNavigationBar: customBottomNav(context),
      body: bodyContent(index),
    );
  }
}
