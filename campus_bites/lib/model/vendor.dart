import 'package:flutter/material.dart';

class Vendor {
  final String id;
  final String name;
  final String subtitle;
  final String imageUrl;
  final Color backgroundColor;
  final double rating;
  final String deliveryTime;
  final bool isFavorite;

  Vendor({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.imageUrl,
    required this.backgroundColor,
    required this.rating,
    required this.deliveryTime,
    this.isFavorite = false,
  });

  Vendor copyWith({bool? isFavorite}) {
    return Vendor(
      id: id,
      name: name,
      subtitle: subtitle,
      imageUrl: imageUrl,
      backgroundColor: backgroundColor,
      rating: rating,
      deliveryTime: deliveryTime,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
