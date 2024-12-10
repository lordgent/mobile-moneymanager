import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  int selectedIndex = 0;

  Future<int> _loadSelectedIndex() async {
    String? savedIndex = await _secureStorage.read(key: 'selectedIndex');
    return savedIndex != null ? int.parse(savedIndex) : 0;
  }

  void _saveSelectedIndex(int index) async {
    await _secureStorage.write(key: 'selectedIndex', value: index.toString());
  }

  void _onItemTapped(BuildContext context, int index) async {
    if (selectedIndex == index) {
      return;
    }

    setState(() {
      selectedIndex = index;
    });
    _saveSelectedIndex(index);

    String route;
    switch (index) {
      case 0:
        route = '/';
        break;
      case 1:
        route = '/transaction';
        break;
      case 3:
        route = '/budget';
        break;
      case 4:
        route = '/profile';
        break;
      default:
        route = '/';
    }

    Navigator.pushNamed(context, route);
  }

  void _showInitTransactionModal(BuildContext context) {
    print("object");
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
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/create-income");
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF00A86B),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
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
              ),
              const SizedBox(width: 35),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/create-expense");
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFFD3C4A),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
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
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _loadSelectedIndex(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); 
        }

        if (snapshot.hasError) {
          return const Text('Error loading index');
        }

        selectedIndex = snapshot.data ?? 0;

        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color.fromARGB(255, 149, 33, 243),
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          onTap: (index) => _onItemTapped(context, index),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                width: 30.0,
                height: 30.0,
                color: selectedIndex == 0
                    ? const Color.fromARGB(255, 149, 33, 243)
                    : Colors.grey, 
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/transaction.svg',
                width: 30.0,
                height: 30.0,
                color: selectedIndex == 1
                    ? const Color.fromARGB(255, 149, 33, 243)
                    : Colors.grey, 
              ),
              label: 'Transaction',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  _showInitTransactionModal(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 149, 33, 243),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/pie-chart.svg',
                width: 30.0,
                height: 30.0,
                color: selectedIndex == 3
                    ? const Color.fromARGB(255, 149, 33, 243)
                    : Colors.grey, 
              ),
              label: 'Budget',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/user.svg',
                width: 30.0,
                height: 30.0,
                color: selectedIndex == 4
                    ? const Color.fromARGB(255, 149, 33, 243)
                    : Colors.grey, 
              ),
              label: 'Profile',
            ),
          ],
        );
      },
    );
  }
}
