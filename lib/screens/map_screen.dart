import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'checkout_screen.dart';
import '../models/food_item.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _showDetail = true;

  final FoodItem _selectedItem = FoodItem(
  id: 'map1',
  name: 'Sushi Mix Tray',
  restaurantName: 'Sakura Sushi Bar',
  imageUrl:
      'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=600',

  description: 'Paket sushi surplus food yang masih layak konsumsi.',
  category: 'Makanan Berat',
  latitude: -7.7956,
  longitude: 110.3695,

  originalPrice: 89000,
  discountedPrice: 35000,
  distanceKm: 1.2,
  pickupTimeStart: '20:30',
  pickupTimeEnd: '21:30',
  remainingCount: 2,
  rating: 4.8,
);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // MAP BACKGROUND PLACEHOLDER
          // TODO: Tambahkan asset sesuai desain (peta interaktif)
          Container(
            color: const Color(0xFFE8EAD0),
            child: CustomPaint(
              painter: _MapPlaceholderPainter(),
              size: Size.infinite,
            ),
          ),

          // Map Markers
          Positioned(
            top: 120,
            left: 60,
            child: _MapMarker(label: '-67%'),
          ),
          Positioned(
            top: 100,
            right: 80,
            child: _MapMarker(label: '-67%', isFood: true),
          ),
          Positioned(
            top: 200,
            right: 100,
            child: _MapMarker(label: '-63%', isBakery: true),
          ),
          // Current location dot
          Positioned(
            top: MediaQuery.of(context).size.height * 0.36,
            left: MediaQuery.of(context).size.width * 0.5 - 8,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          // Selected marker
          Positioned(
            top: MediaQuery.of(context).size.height * 0.39,
            left: MediaQuery.of(context).size.width * 0.5 - 24,
            child: _MapMarker(label: '-61%', isSelected: true),
          ),

          // Bottom Detail Card
          if (_showDetail)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildDetailCard(context),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Image.network(
                        _selectedItem.imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[200],
                          child: const Icon(Icons.restaurant,
                              size: 32, color: Colors.grey),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        left: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '-${_selectedItem.discountPercent}%',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedItem.restaurantName,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _selectedItem.name,
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              size: 13, color: AppColors.textSecondary),
                          Text(
                            '${_selectedItem.distanceKm} km',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.star,
                              size: 13, color: Color(0xFFFFC107)),
                          Text(
                            '${_selectedItem.rating}',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'Rp${_formatPrice(_selectedItem.discountedPrice.toInt())}',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.greenLight,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Rp${_formatPrice(_selectedItem.originalPrice.toInt())}',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutScreen(item: _selectedItem),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                ),
                child: Text(
                  'Lihat Detail',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)}.000';
    }
    return price.toString();
  }
}

class _MapMarker extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isFood;
  final bool isBakery;

  const _MapMarker({
    required this.label,
    this.isSelected = false,
    this.isFood = false,
    this.isBakery = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.textPrimary : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TODO: Tambahkan asset sesuai desain (emoji icon makanan)
          Text(
            isFood
                ? '🌿'
                : isBakery
                    ? '🥐'
                    : '🍱',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _MapPlaceholderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFD4D8B8);
    // Simulate road blocks
    canvas.drawRect(
        Rect.fromLTWH(0, size.height * 0.3, size.width, 40), paint);
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.4, 0, 40, size.height), paint);
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.2, size.height * 0.1, 30, size.height * 0.5),
        paint);

    // Green area
    final greenPaint = Paint()..color = const Color(0xFFBDC8A0).withOpacity(0.6);
    canvas.drawCircle(
        Offset(size.width * 0.2, size.height * 0.15), 80, greenPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}