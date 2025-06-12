import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'model/featured_item.dart';
import 'model/category.dart';
import 'model/vendor.dart';
import 'model/data_generation.dart';

class FeaturedItemsNotifier extends StateNotifier<List<FeaturedItem>> {
  FeaturedItemsNotifier() : super(generateFeaturedItems());

  void refreshFeaturedItems() {
    state = generateFeaturedItems();
  }

  void addFeaturedItem(FeaturedItem item) {
    state = [...state, item];
  }

  void removeFeaturedItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  List<FeaturedItem> getFeaturedByDiscount() {
    return state.where((item) => item.discount.contains('%')).toList();
  }
}

class CategoriesNotifier extends StateNotifier<List<Category>> {
  CategoriesNotifier() : super(generateCategories());

  void selectCategory(String id) {
    state = state.map((category) {
      return category.copyWith(isSelected: category.id == id);
    }).toList();
  }

  void clearSelection() {
    state = state.map((category) {
      return category.copyWith(isSelected: false);
    }).toList();
  }

  List<Category> getSelectedCategories() {
    return state.where((category) => category.isSelected).toList();
  }

  void refreshCategories() {
    state = generateCategories();
  }
}

class VendorsNotifier extends StateNotifier<List<Vendor>> {
  VendorsNotifier() : super(generateVendors());

  void toggleFavorite(String id) {
    state = state.map((vendor) {
      if (vendor.id == id) {
        return vendor.copyWith(isFavorite: !vendor.isFavorite);
      }
      return vendor;
    }).toList();
  }

  List<Vendor> getFavoriteVendors() {
    return state.where((vendor) => vendor.isFavorite).toList();
  }

  List<Vendor> getVendorsByRating(double minRating) {
    return state.where((vendor) => vendor.rating >= minRating).toList();
  }

  List<Vendor> searchVendors(String query) {
    if (query.isEmpty) return state;
    return state.where((vendor) {
      return vendor.name.toLowerCase().contains(query.toLowerCase()) ||
          vendor.subtitle.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void refreshVendors() {
    state = generateVendors();
  }
}

// Providers
final featuredItemsProvider =
    StateNotifierProvider<FeaturedItemsNotifier, List<FeaturedItem>>((ref) {
      return FeaturedItemsNotifier();
    });

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<Category>>((ref) {
      return CategoriesNotifier();
    });

final vendorsProvider = StateNotifierProvider<VendorsNotifier, List<Vendor>>((
  ref,
) {
  return VendorsNotifier();
});

final searchQueryProvider = StateProvider<String>((ref) => '');

// Filtered vendors provider
final filteredVendorsProvider = Provider<List<Vendor>>((ref) {
  final vendors = ref.watch(vendorsProvider);
  final query = ref.watch(searchQueryProvider);

  if (query.isEmpty) return vendors;
  return vendors.where((vendor) {
    return vendor.name.toLowerCase().contains(query.toLowerCase()) ||
        vendor.subtitle.toLowerCase().contains(query.toLowerCase());
  }).toList();
});

//navigation provider
final bottomNavigationIndexProvider = StateProvider<int>((ref) => 0);
