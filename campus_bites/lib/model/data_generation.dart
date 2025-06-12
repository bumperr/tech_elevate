import 'package:flutter/material.dart';
import 'featured_item.dart';
import 'category.dart';
import 'vendor.dart';

List<FeaturedItem> generateFeaturedItems() {
  return [
    FeaturedItem(
      id: '1',
      title: 'The Grill',
      subtitle: 'Special offer today',
      imageUrl: 'https://via.placeholder.com/150x100/4CAF50/FFFFFF?text=Grill',
      discount: '20% off',
      backgroundColor: const Color(0xFF4CAF50),
    ),
    FeaturedItem(
      id: '2',
      title: 'Free Delivery',
      subtitle: 'On orders above \$30',
      imageUrl:
          'https://via.placeholder.com/150x100/2E7D32/FFFFFF?text=Delivery',
      discount: 'Free delivery',
      backgroundColor: const Color(0xFF2E7D32),
    ),
    FeaturedItem(
      id: '3',
      title: 'Pizza Palace',
      subtitle: 'Buy 1 Get 1 Free',
      imageUrl: 'https://via.placeholder.com/150x100/E91E63/FFFFFF?text=Pizza',
      discount: 'BOGO',
      backgroundColor: const Color(0xFFE91E63),
    ),
  ];
}

List<Category> generateCategories() {
  return [
    Category(id: '1', name: 'Burgers', icon: Icons.lunch_dining),
    Category(id: '2', name: 'Sushi', icon: Icons.set_meal),
    Category(id: '3', name: 'Salads', icon: Icons.eco),
    Category(id: '4', name: 'Desserts', icon: Icons.cake),
    Category(id: '5', name: 'Drinks', icon: Icons.local_drink),
    Category(id: '6', name: 'Pizza', icon: Icons.local_pizza),
    Category(id: '7', name: 'Chinese', icon: Icons.ramen_dining),
    Category(id: '8', name: 'Coffee', icon: Icons.coffee),
  ];
}

List<Vendor> generateVendors() {
  final colors = [
    const Color(0xFFFF9800),
    const Color(0xFFFFC107),
    const Color(0xFF795548),
    const Color(0xFF2E7D32),
    const Color(0xFFE91E63),
    const Color(0xFF9C27B0),
    const Color(0xFF3F51B5),
    const Color(0xFF00BCD4),
  ];

  final vendors = [
    {
      'name': 'The Grill',
      'type': 'American • Burgers',
      'rating': 4.5,
      'time': '25-30 min',
    },
    {
      'name': 'Campus Cafe',
      'type': 'Coffee • Snacks',
      'rating': 4.2,
      'time': '15-20 min',
    },
    {
      'name': 'Sushi Express',
      'type': 'Japanese • Sushi',
      'rating': 4.7,
      'time': '30-35 min',
    },
    {
      'name': 'Pasta Paradise',
      'type': 'Italian • Pasta',
      'rating': 4.4,
      'time': '20-25 min',
    },
    {
      'name': 'Taco Town',
      'type': 'Mexican • Tacos',
      'rating': 4.3,
      'time': '15-25 min',
    },
    {
      'name': 'Smoothie Shack',
      'type': 'Healthy • Smoothies',
      'rating': 4.6,
      'time': '10-15 min',
    },
    {
      'name': 'Dragon Palace',
      'type': 'Chinese • Noodles',
      'rating': 4.1,
      'time': '20-30 min',
    },
    {
      'name': 'Bean & Brew',
      'type': 'Coffee • Pastries',
      'rating': 4.8,
      'time': '5-10 min',
    },
  ];

  return vendors.asMap().entries.map((entry) {
    final index = entry.key;
    final vendor = entry.value;

    return Vendor(
      id: (index + 1).toString(),
      name: vendor['name'] as String,
      subtitle: vendor['type'] as String,
      imageUrl:
          'https://via.placeholder.com/80x80/${colors[index].value.toRadixString(16).substring(2)}/FFFFFF?text=${vendor['name'].toString().split(' ').map((e) => e[0]).join('')}',
      backgroundColor: colors[index],
      rating: vendor['rating'] as double,
      deliveryTime: vendor['time'] as String,
    );
  }).toList();
}
