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
    Category(id: '2', name: 'Rice', icon: Icons.rice_bowl),
    Category(id: '3', name: 'Snacks', icon: Icons.fastfood),
    Category(id: '4', name: 'Desserts', icon: Icons.cake),
    Category(id: '5', name: 'Drinks', icon: Icons.local_drink),
    Category(id: '6', name: 'Pizza', icon: Icons.local_pizza),
    Category(id: '7', name: 'Coffee', icon: Icons.coffee),
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
      'name': 'Manja Burger',
      'type': 'American • Burgers',
      'rating': 4.5,
      'time': '25-30 min',
      'categories_id': {'1'},
      'image_URL':
          'https://scontent.fpen1-1.fna.fbcdn.net/v/t39.30808-6/303285053_516179960511643_2624171546720026263_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=QjIdxrzea-4Q7kNvwGRsCIR&_nc_oc=Adnrnk5Dvw8C7NPF1reRFU_Vb40g0cBTKYCeFaO6p2UygD7oYGQPkgNB9o_utEcD4Ck&_nc_zt=23&_nc_ht=scontent.fpen1-1.fna&_nc_gid=szykECY-FA6QcVBH_7MqHg&oh=00_AfMlIIdeUJ-wM2wb2N5M74sILYfHI4n4iB1rbv0yftE7XQ&oe=6851B86D',
    },
    {
      'name': 'He and She Coffee',
      'type': 'Coffee • Desserts',
      'rating': 4.2,
      'time': '15-20 min',
      'categories_id': {'5', '7', '4'},
      'image_URL':
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1b/43/20/23/they-also-outdoor-seat.jpg?w=1400&h=800&s=1',
    },
    {
      'name': 'Cafe V2 GEE & S',
      'type': 'Malay • Rice',
      'rating': 4.7,
      'time': '30-35 min',
      'categories_id': {'2'},
      'image_URL':
          'https://www.utp.edu.my/PublishingImages/Pages/Students/Student%20Development%20and%20Services/Facilities%20and%20Services/Cafeteria/2023/Village%202%20-%20Gee%20%26%20S.jpg',
    },
    {
      'name': 'Pasta V4',
      'type': 'Italian • Pasta',
      'rating': 4.4,
      'time': '20-25 min',
      'categories_id': {'1', '2'},
      'image_URL':
          'https://www.utp.edu.my/PublishingImages/Pages/Students/Student%20Development%20and%20Services/Facilities%20and%20Services/Cafeteria/2023/Village%204%20-%20Zaitom%20Razak%20Cafe.jpg',
    },

    {
      'name': 'V5 Afifah Beta',
      'type': 'Healthy • Smoothies',
      'rating': 4.6,
      'time': '10-15 min',
      'categories_id': {'5', '7'},
      'image_URL':
          'https://www.utp.edu.my/PublishingImages/Pages/Students/Student%20Development%20and%20Services/Facilities%20and%20Services/Cafeteria/2023/Village%205%20(b)%20-%20Afifah%20Beta.jpg',
    },
  ];

  return vendors.asMap().entries.map((entry) {
    final index = entry.key;
    final vendor = entry.value;

    return Vendor(
      id: (index + 1).toString(),
      name: vendor['name'] as String,
      subtitle: vendor['type'] as String,
      imageUrl: vendor['image_URL'] as String,
      categoriesId: vendor['categories_id'] as Set<String>,
      backgroundColor: colors[index],
      rating: vendor['rating'] as double,
      deliveryTime: vendor['time'] as String,
    );
  }).toList();
}
