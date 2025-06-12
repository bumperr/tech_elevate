import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campus_bites/screen/component/app_bar.dart';
import 'package:campus_bites/screen/component/nav_bar.dart';

class OrderPage extends ConsumerWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: buildCustomAppBar(),
      body: const Center(child: Text('this is orderpage')),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
