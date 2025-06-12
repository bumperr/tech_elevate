import 'package:flutter/material.dart';
import 'package:campus_bites/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesSection extends ConsumerWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  ref
                      .read(categoriesProvider.notifier)
                      .selectCategory(category.id);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: category.isSelected
                              ? Colors.orange[100]
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: category.isSelected
                                ? Colors.orange
                                : Colors.grey[300]!,
                            width: category.isSelected ? 2 : 1,
                          ),
                        ),
                        child: Icon(
                          category.icon,
                          color: category.isSelected
                              ? Colors.orange
                              : Colors.grey[600],
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        category.name,
                        style: TextStyle(
                          fontSize: 12,
                          color: category.isSelected
                              ? Colors.orange
                              : Colors.grey[600],
                          fontWeight: category.isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
