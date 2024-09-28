import 'package:flutter/material.dart';

class BottomTab extends StatelessWidget {
  const BottomTab({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;

    void _onItemTapped(BuildContext context, int index) {
      String route;
      switch (index) {
        case 0:
          route = '/';
          break;
        case 1:
          route = '/transaction';
          break;
        case 2:
          route = '/report';
          break;
        case 3:
          route = '/profile';
          break;
        default:
          route = '/';
      }
      Navigator.pushReplacementNamed(context, route);
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color.fromARGB(255, 149, 33, 243),
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
      onTap: (index) => _onItemTapped(context, index),
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.import_export),
          label: 'Transaction',
        ),
        BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 149, 33, 243),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0), // Padding untuk efek visual
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart),
          label: 'Report',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
