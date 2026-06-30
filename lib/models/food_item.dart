class FoodItem {
  final String id;
  final String name;
  final String restaurantName;
  final String imageUrl;
  final double originalPrice;
  final double discountedPrice;
  final double distanceKm;
  final String pickupTimeStart;
  final String pickupTimeEnd;
  final int remainingCount;
  final String? tag; // 'VEGAN', 'ECO', 'HAMPIR HABIS', 'DISELAMATKAN'
  final double? rating;
  final bool isNew;

  FoodItem({
    required this.id,
    required this.name,
    required this.restaurantName,
    required this.imageUrl,
    required this.originalPrice,
    required this.discountedPrice,
    required this.distanceKm,
    required this.pickupTimeStart,
    required this.pickupTimeEnd,
    required this.remainingCount,
    this.tag,
    this.rating,
    this.isNew = false,
  });

  int get discountPercent =>
      (((originalPrice - discountedPrice) / originalPrice) * 100).round();
}