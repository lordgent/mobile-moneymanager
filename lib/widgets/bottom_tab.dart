import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int selectedIndex = 0;

  void _onItemTapped(BuildContext context, int index) {
    if (selectedIndex == index) {
      return;
    }

    setState(() {
      selectedIndex = index;
    });

    if (index == 2) {
      _showInitTransactionModal(context);
      return;
    }

    String route;
    switch (index) {
      case 0:
        route = '/';
        break;
      case 1:
        route = '/transaction';
        break;
      case 3:
        route = '/report';
        break;
      case 4:
        route = '/profile';
        break;
      default:
        route = '/';
    }

    Navigator.pushReplacementNamed(context, route);
  }

  void _showInitTransactionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 230,
          color: Colors.transparent,
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFF00A86B),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    color: Colors.white,
                    'assets/icons/income.svg',
                    width: 35.0,
                    height: 35.0,
                  ),
                ),
              ),
              const SizedBox(width: 35),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFFD3C4A),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    color: Colors.white,
                    'assets/icons/expense.svg',
                    width: 35.0,
                    height: 35.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color.fromARGB(255, 149, 33, 243),
      unselectedItemColor: Colors.grey,
      currentIndex: selectedIndex,
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
              padding: EdgeInsets.all(8.0),
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
