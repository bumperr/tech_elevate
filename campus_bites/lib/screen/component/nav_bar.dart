import 'package:flutter/material.dart';
import 'package:campus_bites/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campus_bites/screen/home/home_screen.dart';
import 'package:campus_bites/screen/account/account_screen.dart';
import 'package:campus_bites/screen/order/order_screen.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavigationIndexProvider);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (index) {
          // Update the provider state
          ref.read(bottomNavigationIndexProvider.notifier).state = index;

          // Navigate to the corresponding page
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                // (route) => false, // Removes ALL previous routes
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderPage()),
                // (route) => false, // Removes ALL previous routes
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountPage()),
                // (route) => false, // Removes ALL previous routes
              );
          }
        },

        items: const [
          //Home navigation bar
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
