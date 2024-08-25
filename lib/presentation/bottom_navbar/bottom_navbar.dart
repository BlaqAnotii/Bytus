import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/presentation/widget_screens/home.dart';
import 'package:bytuswallet/presentation/widget_screens/my_wallet.dart';
import 'package:bytuswallet/presentation/widget_screens/profile.dart';
import 'package:bytuswallet/presentation/widget_screens/transaction_history.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavBarScreen extends StatefulWidget {


  const BottomNavBarScreen(
      {super.key,
      });

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {


  @override
  void initState() {
    super.initState();
   
    _pages.add(const HomeScreen());
    _pages.add(const WalletScreen());
    _pages.add(const ProfileScreen(
     
    ));
  }

  int _activeTab = 0;

  final List<Widget> _pages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_activeTab),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedIconTheme: const IconThemeData(color: offcolor),
        selectedItemColor: offcolor,
        onTap: (value) {
          setState(() {
            _activeTab = value;
          });
        },
        currentIndex: _activeTab,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.home,
              size: 25,
              color: primary,
            ),
            label: "Home",
          ),
        
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.wallet,
              size: 25,
              color: primary,
            ),
            label: "My Wallet",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.profile_circle,
              size: 25,
              color: primary,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
