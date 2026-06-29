import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/food_item.dart';
import '../theme/app_theme.dart';
import '../widgets/banner_promo.dart';
import '../widgets/category_chip.dart';
import '../widgets/food_card_home.dart';
import '../widgets/section_header.dart';
import 'checkout_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<FoodItem> _recommendations = [
    FoodItem(
      id: '1',
      name: 'Green Garden Cafe',
      restaurantName: 'Green Garden Cafe',
      imageUrl:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600',
      originalPrice: 40000,
      discountedPrice: 17000,
      distanceKm: 0.8,
      pickupTimeStart: '18:00',
      pickupTimeEnd: '19:30',
      remainingCount: 3,
      tag: 'PILIHAN VEGAN',
    ),
    FoodItem(
      id: '2',
      name: 'The Crusty Loaf',
      restaurantName: 'The Crusty Loaf',
      imageUrl:
          'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=600',
      originalPrice: 23000,
      discountedPrice: 8000,
      distanceKm: 1.2,
      pickupTimeStart: '17:30',
      pickupTimeEnd: '19:00',
      remainingCount: 5,
      tag: 'RAMAH LINGKUNGAN',
    ),
    FoodItem(
      id: '3',
      name: 'Sushi Zen',
      restaurantName: 'Sushi Zen',
      imageUrl:
          'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=600',
      originalPrice: 89000,
      discountedPrice: 35000,
      distanceKm: 2.5,
      pickupTimeStart: '20:00',
      pickupTimeEnd: '21:00',
      remainingCount: 1,
      tag: 'HAMPIR HABIS',
    ),
    FoodItem(
      id: '4',
      name: 'Kedai Nasi Padang Berkah',
      restaurantName: 'Kedai Nasi Padang Berkah',
      imageUrl:
          'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=600',
      originalPrice: 24000,
      discountedPrice: 10000,
      distanceKm: 0.5,
      pickupTimeStart: '17:00',
      pickupTimeEnd: '19:30',
      remainingCount: 4,
      tag: 'DISELAMATKAN HARI INI',
    ),
    FoodItem(
      id: '5',
      name: 'Snack Box SuperMarket',
      restaurantName: 'Snack Box SuperMarket',
      imageUrl:
          'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=600',
      originalPrice: 26000,
      discountedPrice: 12000,
      distanceKm: 1.0,
      pickupTimeStart: '18:30',
      pickupTimeEnd: '20:00',
      remainingCount: 6,
      tag: 'DISELAMATKAN HARI INI',
    ),
  ];

  static final List<Map<String, dynamic>> _categories = [
    {'label': 'Makanan Berat', 'icon': Icons.restaurant},
    {'label': 'Cemilan', 'icon': Icons.cookie_outlined},
    {'label': 'Roti & Kue', 'icon': Icons.bakery_dining},
    {'label': 'Sayuran', 'icon': Icons.eco_outlined},
    {'label': 'Minuman', 'icon': Icons.local_drink_outlined},
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
                    _buildHeader(),
                    const SizedBox(height: 16),
                    _buildSearchBar(context),
                    const SizedBox(height: 16),
                    const BannerPromo(),
                    const SizedBox(height: 24),
                    _buildCategories(),
                    const SizedBox(height: 24),
                    _buildRecommendationsHeader(context),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => FoodCardHome(
                    item: _recommendations[index],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CheckoutScreen(item: _recommendations[index]),
                      ),
                    ),
                  ),
                  childCount: _recommendations.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // TODO: Tambahkan asset sesuai desain (avatar user)
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.primary.withOpacity(0.2),
              child: const Icon(Icons.person,
                  color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, Food Hero!',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 13, color: AppColors.primary),
                    const SizedBox(width: 2),
                    Text(
                      'Jogja, Banguntapan',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined,
                  color: AppColors.textPrimary, size: 26),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(Icons.search, color: AppColors.textSecondary, size: 20),
          const SizedBox(width: 8),
          Text(
            'Cari makanan atau restoran...',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Kategori',
          actionText: 'See all',
          onAction: () {},
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _categories
                .asMap()
                .entries
                .map(
                  (e) => Padding(
                    padding: EdgeInsets.only(
                      right: e.key < _categories.length - 1 ? 16 : 0,
                    ),
                    child: CategoryChip(
                      label: e.value['label'],
                      icon: e.value['icon'],
                      isSelected: e.key == 0,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Rekomendasi di Sekitarmu',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const Icon(Icons.tune, color: AppColors.textPrimary, size: 22),
      ],
    );
  }
}