class Food {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String vendorId;
  final bool isAvailable;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.vendorId,
    this.isAvailable = true,
  });

  Food copyWith({bool? isAvailable}) {
    return Food(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      price: price,
      vendorId: vendorId,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
