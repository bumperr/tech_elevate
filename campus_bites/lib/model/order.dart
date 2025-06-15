class Order {
  final String id;
  final String vendorId;
  final String userId;
  final String orderDate;
  final String deliveryTime;
  final double totalPrice;
  final List<String> foodids;

  Order({
    required this.id,
    required this.vendorId,
    required this.userId,
    required this.orderDate,
    required this.deliveryTime,
    required this.totalPrice,
    required this.foodids,
  });
}
