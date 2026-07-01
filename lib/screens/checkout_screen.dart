import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/food_item.dart';
import '../theme/app_theme.dart';
import '../models/order.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final FoodItem item;

  const CheckoutScreen({super.key, required this.item});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedTime = '18:00';
  int _quantity = 1;
  String _selectedPayment = 'ewallet';

  final List<String> _times = ['17:30', '18:00', '18:30', '19:00', '19:30'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                _buildImageHeader(context),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFoodInfo(),
                        const SizedBox(height: 24),
                        _buildTimePicker(),
                        const SizedBox(height: 24),
                        _buildQuantitySelector(),
                        const SizedBox(height: 24),
                        _buildPaymentMethods(),
                        const SizedBox(height: 24),
                        _buildPriceSummary(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildConfirmButton(context),
        ],
      ),
    );
  }

  Widget _buildImageHeader(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 260,
      pinned: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1), blurRadius: 6)
            ],
          ),
          child: const Icon(Icons.arrow_back,
              color: AppColors.textPrimary, size: 20),
        ),
      ),
      title: Text(
        'Checkout',
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryDark,
        ),
      ),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              widget.item.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey[200],
                child: const Icon(Icons.restaurant,
                    size: 64, color: Colors.grey),
              ),
            ),
            Positioned(
              top: 80,
              left: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '-${widget.item.discountPercent}%',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0EBE3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.item.restaurantName,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.item.name,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Berisi aneka sushi roll dan sashimi pilihan hari ini — bisa berupa nigiri salmon, california roll, atau tempura roll. Tetap segar, baru dibuat hari ini, hanya kemasannya kami selamatkan dari terbuang.',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                '${widget.item.distanceKm} km',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.access_time,
                  size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                '${widget.item.pickupTimeStart} — ${widget.item.pickupTimeEnd}',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih jam pengambilan',
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _times
                .map(
                  (t) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTime = t),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: _selectedTime == t
                              ? AppColors.textPrimary
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _selectedTime == t
                                ? AppColors.textPrimary
                                : const Color(0xFFE0D6C8),
                          ),
                        ),
                        child: Text(
                          t,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: _selectedTime == t
                                ? Colors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jumlah pesanan',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '2 porsi tersisa',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (_quantity > 1) setState(() => _quantity--);
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F0E8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.remove,
                        size: 18, color: AppColors.textPrimary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '$_quantity',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _quantity++),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add,
                        size: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Metode Pembayaran',
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        _PaymentOption(
          icon: Icons.account_balance_wallet_outlined,
          label: 'E-wallet',
          value: 'ewallet',
          selected: _selectedPayment,
          onTap: (v) => setState(() => _selectedPayment = v),
        ),
        const SizedBox(height: 10),
        _PaymentOption(
          icon: Icons.account_balance_outlined,
          label: 'Transfer Bank',
          value: 'bank',
          selected: _selectedPayment,
          onTap: (v) => setState(() => _selectedPayment = v),
        ),
        const SizedBox(height: 10),
        _PaymentOption(
          icon: Icons.payments_outlined,
          label: 'Bayar di Tempat',
          value: 'cash',
          selected: _selectedPayment,
          onTap: (v) => setState(() => _selectedPayment = v),
        ),
      ],
    );
  }

  Widget _buildPriceSummary() {
    final discount = widget.item.originalPrice - widget.item.discountedPrice;
    return Column(
      children: [
        _PriceLine(
          label: 'Harga Asli',
          value: 'Rp${_fmt(widget.item.originalPrice.toInt())}',
          valueStyle: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textSecondary,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        const SizedBox(height: 6),
        _PriceLine(
          label: 'Diskon Eco',
          value: _fmt(discount.toInt()),
          valueStyle: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.green,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(color: Color(0xFFF0EBE3)),
        ),
        _PriceLine(
          label: 'Total Pesanan',
          value: 'Rp ${_fmt(widget.item.discountedPrice.toInt())}',
          valueStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark,
          ),
          labelStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
          16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Tentukan jam selesai pickup (1 slot setelah jam yang dipilih)
            final selectedIndex = _times.indexOf(_selectedTime);
            final endTime = selectedIndex + 1 < _times.length
                ? _times[selectedIndex + 1]
                : _selectedTime;

            final newOrder = Order(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              restaurantName: widget.item.restaurantName,
              restaurantAddress: 'Jl. Kusuma Jaya',
              restaurantImageUrl: widget.item.imageUrl,
              packageName: widget.item.name,
              packageSubtitle: 'Premium Selection',
              pickupTimeStart: _selectedTime,
              pickupTimeEnd: endTime,
              price: widget.item.discountedPrice * _quantity,
              originalPrice: widget.item.originalPrice,
              imageUrl: widget.item.imageUrl,
              status: OrderStatus.menunggu,
              pickupCode:
                  'SB-${1000 + (DateTime.now().millisecondsSinceEpoch % 9000)}',
              orderTime: 'Hari ini, ${TimeOfDay.now().format(context)}',
              paymentMethod: _selectedPayment == 'ewallet'
                  ? 'E-wallet'
                  : _selectedPayment == 'bank'
                      ? 'Transfer Bank'
                      : 'Bayar di Tempat',
              distanceKm: widget.item.distanceKm,
              quantity: _quantity,
              discountPercent: widget.item.discountPercent,
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => OrderSuccessScreen(order: newOrder),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Konfirmasi Pesanan',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  String _fmt(int price) {
    if (price >= 1000) return '${(price / 1000).toStringAsFixed(0)}.000';
    return price.toString();
  }
}

class _PaymentOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String selected;
  final Function(String) onTap;

  const _PaymentOption({
    required this.icon,
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selected == value;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryDark
                : const Color(0xFFE0D6C8),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceLine extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;
  final TextStyle? labelStyle;

  const _PriceLine({
    required this.label,
    required this.value,
    this.valueStyle,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: labelStyle ??
              GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
        ),
        Text(
          value,
          style: valueStyle ??
              GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
        ),
      ],
    );
  }
}