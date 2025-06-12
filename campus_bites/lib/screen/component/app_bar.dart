import 'package:flutter/material.dart';

PreferredSizeWidget buildCustomAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 2,
    shadowColor: Colors.black12,
    toolbarHeight: 70,
    title: const Text(
      'CampusBites',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
    actions: [
      Container(
        margin: const EdgeInsets.only(right: 8),
        child: Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black54,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    ],
    centerTitle: false,
  );
}

PreferredSizeWidget buildCustomAppBarAccount() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 2,
    shadowColor: Colors.black12,
    toolbarHeight: 70,
    title: const Text(
      'Account',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),

    centerTitle: true,
  );
}
