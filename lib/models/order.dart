enum OrderStatus { menunggu, selesai, dibatalkan }

class Order {
  final String id;
  final String restaurantName;
  final String restaurantAddress;
  final String restaurantImageUrl;
  final String packageName;
  final String? packageSubtitle;
  final String pickupTimeStart;
  final String pickupTimeEnd;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final OrderStatus status;
  final String pickupCode;
  final String orderTime;
  final String paymentMethod;
  final double distanceKm;
  final int quantity;
  final int? discountPercent;

  Order({
    required this.id,
    required this.restaurantName,
    this.restaurantAddress = '',
    this.restaurantImageUrl = '',
    required this.packageName,
    this.packageSubtitle,
    required this.pickupTimeStart,
    required this.pickupTimeEnd,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    this.status = OrderStatus.menunggu,
    required this.pickupCode,
    this.orderTime = '',
    this.paymentMethod = 'E-wallet',
    this.distanceKm = 0,
    this.quantity = 1,
    this.discountPercent,
  });

  bool get isActive => status == OrderStatus.menunggu;
}