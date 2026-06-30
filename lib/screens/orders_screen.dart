import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/order.dart';
import '../theme/app_theme.dart';
import '../widgets/order_card.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isActive = true;

  static final List<Order> _activeOrders = [
    Order(
      id: '1',
      restaurantName: 'Warung Mama Sari',
      packageName: 'Paket Nasi Padang Surprise',
      pickupTimeStart: '17:30',
      pickupTimeEnd: '19:00',
      price: 15000,
      imageUrl:
          'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=400',
      isActive: true,
    ),
    Order(
      id: '2',
      restaurantName: 'Roti Boulangerie',
      packageName: 'Magic Bakery Box',
      pickupTimeStart: '18:00',
      pickupTimeEnd: '20:00',
      price: 22000,
      imageUrl:
          'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400',
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pesanan Saya',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Riwayat & aktif',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              _buildTabRow(),
              const SizedBox(height: 20),
              Expanded(
                child: _isActive
                    ? _buildActiveOrders()
                    : _buildEmptyCompleted(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabRow() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _isActive = true),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: _isActive ? AppColors.textPrimary : Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: Text(
                'Aktif',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _isActive ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _isActive = false),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: !_isActive ? AppColors.textPrimary : Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: Text(
                'Selesai',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: !_isActive ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ✅ FIX: Column diganti ListView agar tidak overflow
  Widget _buildActiveOrders() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ..._activeOrders.map((o) => OrderCard(order: o)),
        const SizedBox(height: 16),
        _buildSavedCounter(),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSavedCounter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            size: 40,
            color: Color(0xFF4CAF50),
          ),
          const SizedBox(height: 10),
          Text(
            '14 paket diselamatkan',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.green,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Setara dengan 7.2 kg CO',
                style: GoogleFonts.inter(fontSize: 13, color: AppColors.green),
              ),
              Text(
                '₂',
                style: GoogleFonts.inter(fontSize: 11, color: AppColors.green),
              ),
              Text(
                ' dihemat ',
                style: GoogleFonts.inter(fontSize: 13, color: AppColors.green),
              ),
              const Text('🌍', style: TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCompleted() {
    return Center(
      child: Text(
        'Belum ada pesanan selesai',
        style: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}