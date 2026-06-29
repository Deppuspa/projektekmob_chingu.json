import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/food_item.dart';
import '../theme/app_theme.dart';

class FoodCardList extends StatelessWidget {
  final FoodItem item;
  final VoidCallback? onOrder;

  const FoodCardList({super.key, required this.item, this.onOrder});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ImageSection(item: item),
          Padding(
            padding: const EdgeInsets.all(12),
            child: _InfoSection(item: item, onOrder: onOrder),
          ),
        ],
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  final FoodItem item;
  const _ImageSection({required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Image.network(
            item.imageUrl,
            width: double.infinity,
            height: 170,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 170,
              color: Colors.grey[200],
              child: const Icon(Icons.restaurant, size: 48, color: Colors.grey),
            ),
          ),
        ),
        if (item.tag == 'HAMPIR HABIS')
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'HAMPIR HABIS',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        if (item.isNew)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'NEW',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _InfoSection extends StatelessWidget {
  final FoodItem item;
  final VoidCallback? onOrder;

  const _InfoSection({required this.item, this.onOrder});

  Color get _remainingColor =>
      item.remainingCount <= 3 ? AppColors.red : AppColors.green;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Rp${_formatPrice(item.originalPrice.toInt())}',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Rp${_formatPrice(item.discountedPrice.toInt())}',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.storefront_outlined,
                size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(
              item.restaurantName,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.inventory_2_outlined,
                size: 14, color: _remainingColor),
            const SizedBox(width: 4),
            Text(
              'Tersisa ${item.remainingCount} porsi',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: _remainingColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.location_on_outlined,
                size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 2),
            Text(
              '${item.distanceKm} km dari kamu',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onOrder,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              elevation: 0,
            ),
            child: Text(
              'Pesan Sekarang',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatPrice(int price) {
    if (price >= 1000) {
      final result = (price / 1000).toStringAsFixed(0);
      return '$result.000';
    }
    return price.toString();
  }
}