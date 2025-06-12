import 'package:flutter/material.dart';

class FeaturedItem {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String discount;
  final Color backgroundColor;

  FeaturedItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.discount,
    required this.backgroundColor,
  });
}
