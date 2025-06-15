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
    /// Adds a new item to the current state list by creating a new list
    /// that contains all existing items followed by the new [item].
    /// This ensures the state is updated immutably.
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

/// Provides a [FeaturedItemsNotifier] to manage and expose a list of [FeaturedItem]s.
///
/// This [StateNotifierProvider] is responsible for creating and managing the lifecycle
/// of a [FeaturedItemsNotifier], which holds the state of a list of featured items.
///
/// The provider allows widgets to listen to changes in the list of featured items and
/// rebuild accordingly when the state updates. It is typically used to separate business
/// logic from UI and to facilitate state management in a scalable way.
///
/// Usage:
/// - Access the current list of featured items by watching this provider.
/// - Use the notifier to perform actions such as adding, removing, or updating featured items.
///
/// Example:
/// ```dart
/// final featuredItems = ref.watch(featuredItemsProvider);
/// ```
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
