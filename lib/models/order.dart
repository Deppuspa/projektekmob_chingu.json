class Order {
  final String id;
  final String restaurantName;
  final String packageName;
  final String pickupTimeStart;
  final String pickupTimeEnd;
  final double price;
  final String imageUrl;
  final bool isActive;

  Order({
    required this.id,
    required this.restaurantName,
    required this.packageName,
    required this.pickupTimeStart,
    required this.pickupTimeEnd,
    required this.price,
    required this.imageUrl,
    required this.isActive,
  });
}