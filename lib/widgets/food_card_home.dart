import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/food_item.dart';
import '../theme/app_theme.dart';

class FoodCardHome extends StatelessWidget {
  final FoodItem item;
  final VoidCallback? onTap;

  const FoodCardHome({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
              child: _InfoSection(item: item),
            ),
          ],
        ),
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
            height: 180,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 180,
              color: Colors.grey[200],
              child: const Icon(Icons.restaurant, size: 48, color: Colors.grey),
            ),
          ),
        ),
        // Badge TERSISA X
        Positioned(
          top: 12,
          right: 12,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.badgeRed,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'TERSISA ${item.remainingCount}',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        // Pickup time
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.55),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.access_time,
                    color: Colors.white, size: 12),
                const SizedBox(width: 4),
                Text(
                  '${item.pickupTimeStart} - ${item.pickupTimeEnd}',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoSection extends StatelessWidget {
  final FoodItem item;
  const _InfoSection({required this.item});

  Color get _tagColor {
    switch (item.tag) {
      case 'PILIHAN VEGAN':
        return AppColors.green;
      case 'RAMAH LINGKUNGAN':
        return AppColors.green;
      case 'HAMPIR HABIS':
        return AppColors.red;
      case 'DISELAMATKAN HARI INI':
        return AppColors.green;
      default:
        return AppColors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                item.name,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Rp ${_formatPrice(item.discountedPrice.toInt())}',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Rp${_formatPrice(item.originalPrice.toInt())}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.location_on_outlined,
                size: 13, color: AppColors.textSecondary),
            const SizedBox(width: 2),
            Text(
              '${item.distanceKm} km dari kamu',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        if (item.tag != null) ...[
          const SizedBox(height: 8),
          Text(
            item.tag!,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _tagColor,
            ),
          ),
        ],
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