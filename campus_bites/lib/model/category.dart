import 'package:flutter/material.dart';

//Used for the first page
class Category {
  final String id;
  final String name;
  final IconData icon;
  final bool isSelected;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    this.isSelected = false,
  });

  Category copyWith({bool? isSelected}) {
    return Category(
      id: id,
      name: name,
      icon: icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}


