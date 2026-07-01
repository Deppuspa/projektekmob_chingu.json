class FoodItem {
  final String id;
  final String name;
  final String restaurantName;
  final String imageUrl;
  final String description;
  final String category;
  final double originalPrice;
  final double discountedPrice;
  final double distanceKm;
  final double latitude;
  final double longitude;
  final String pickupTimeStart;
  final String pickupTimeEnd;
  final int remainingCount;
  final String? tag; 
  final double? rating;
  final bool isNew;

  FoodItem({
    required this.id,
    required this.name,
    required this.restaurantName,
    required this.imageUrl,
    required this.description,
    required this.category,
    required this.originalPrice,
    required this.discountedPrice,
    required this.distanceKm,
    required this.latitude,
    required this.longitude,
    required this.pickupTimeStart,
    required this.pickupTimeEnd,
    required this.remainingCount,
    this.tag,
    this.rating,
    this.isNew = false,
  });

  int get discountPercent =>
      (((originalPrice - discountedPrice) / originalPrice) * 100).round();

   factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json["id"].toString(),
      name: json["name"],
      restaurantName: json["restaurantName"],
      imageUrl: json["imageUrl"],
      description: json["description"],
      category: json["category"],
      originalPrice: (json["originalPrice"] as num).toDouble(),
      discountedPrice: (json["discountedPrice"] as num).toDouble(),
      distanceKm: (json["distanceKm"] as num).toDouble(),
      latitude: (json["latitude"] as num).toDouble(),
      longitude: (json["longitude"] as num).toDouble(),
      pickupTimeStart: json["pickupTimeStart"],
      pickupTimeEnd: json["pickupTimeEnd"],
      remainingCount: json["remainingCount"],
      tag: json["tag"],
      rating: json["rating"] != null
          ? (json["rating"] as num).toDouble()
          : null,
      isNew: json["isNew"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "restaurantName": restaurantName,
      "imageUrl": imageUrl,
      "description": description,
      "category": category,
      "originalPrice": originalPrice,
      "discountedPrice": discountedPrice,
      "distanceKm": distanceKm,
      "latitude": latitude,
      "longitude": longitude,
      "pickupTimeStart": pickupTimeStart,
      "pickupTimeEnd": pickupTimeEnd,
      "remainingCount": remainingCount,
      "tag": tag,
      "rating": rating,
      "isNew": isNew,
    };
  }
}