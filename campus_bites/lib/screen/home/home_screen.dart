import 'package:flutter/material.dart';
import 'package:campus_bites/screen/component/app_bar.dart';
import 'package:campus_bites/screen/component/nav_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campus_bites/screen/home/component/search_bar.dart';
import 'package:campus_bites/screen/home/component/featured_section.dart';
import 'package:campus_bites/screen/home/component/categories_section.dart';
import 'package:campus_bites/screen/home/component/vendors_section.dart';

// Main Screen
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildCustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBarWidget(),
            const SizedBox(height: 8),
            const FeaturedSection(),
            const SizedBox(height: 24),
            const CategoriesSection(),
            const SizedBox(height: 24),
            const VendorsSection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
