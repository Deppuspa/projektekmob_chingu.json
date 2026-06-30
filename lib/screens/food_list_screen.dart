import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/food_item.dart';
import '../theme/app_theme.dart';
import '../widgets/food_card_list.dart';
import 'checkout_screen.dart';

class FoodListScreen extends StatelessWidget {
  const FoodListScreen({super.key});

  static final List<FoodItem> _items = [
    FoodItem(
      id: '1',
      name: 'Aneka Pastri Sore',
      restaurantName: 'Fullsun Bakery',
      imageUrl:
          'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=600',
      originalPrice: 35000,
      discountedPrice: 15000,
      distanceKm: 1.2,
      pickupTimeStart: '17:00',
      pickupTimeEnd: '19:00',
      remainingCount: 5,
      tag: 'HAMPIR HABIS',
    ),
    FoodItem(
      id: '2',
      name: 'Sushi Set',
      restaurantName: 'Sushi Yeay',
      imageUrl:
          'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=600',
      originalPrice: 75000,
      discountedPrice: 32000,
      distanceKm: 0.8,
      pickupTimeStart: '18:00',
      pickupTimeEnd: '20:00',
      remainingCount: 12,
      isNew: true,
    ),
    FoodItem(
      id: '3',
      name: 'Rice Bowl Hemat',
      restaurantName: 'Kobessah',
      imageUrl:
          'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=600',
      originalPrice: 45000,
      discountedPrice: 12000,
      distanceKm: 2.5,
      pickupTimeStart: '17:00',
      pickupTimeEnd: '19:00',
      remainingCount: 3,
    ),
    FoodItem(
      id: '4',
      name: 'Fresh Salad',
      restaurantName: 'Green Bites Cafe',
      imageUrl:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600',
      originalPrice: 28000,
      discountedPrice: 9000,
      distanceKm: 3.1,
      pickupTimeStart: '18:00',
      pickupTimeEnd: '20:00',
      remainingCount: 2,
      tag: 'HAMPIR HABIS',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 16),
                    _buildFilterRow(),
                    const SizedBox(height: 20),
                    Text(
                      'Tersedia di Dekat Anda',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Simpan hidangan lezat dan bantu melestarikan bumi.',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => FoodCardList(
                    item: _items[index],
                    onOrder: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CheckoutScreen(item: _items[index]),
                      ),
                    ),
                  ),
                  childCount: _items.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Telusuri Makanan',
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Row(
          children: [
            // TODO: Tambahkan asset sesuai desain (avatar user)
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primary.withOpacity(0.2),
              child: const Icon(Icons.person,
                  color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.notifications_outlined,
                color: AppColors.textPrimary, size: 24),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(label: 'Lokasi', icon: Icons.location_on, isSelected: true),
          const SizedBox(width: 10),
          _FilterChip(
              label: 'Harga', icon: Icons.local_offer_outlined),
          const SizedBox(width: 10),
          _FilterChip(
              label: 'Kategori', icon: Icons.tune_outlined),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;

  const _FilterChip({
    required this.label,
    required this.icon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}