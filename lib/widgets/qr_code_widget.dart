import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../theme/app_theme.dart';

class QrCodeWidget extends StatelessWidget {
  final String data;
  final double size;
  final bool isExpired;

  const QrCodeWidget({
    super.key,
    required this.data,
    this.size = 200,
    this.isExpired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFEDEAFB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Opacity(
              opacity: isExpired ? 0.35 : 1,
              child: QrImageView(
                data: data,
                version: QrVersions.auto,
                backgroundColor: Colors.transparent,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: Color(0xFF4A3F8C),
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: Color(0xFF4A3F8C),
                ),
              ),
            ),
          ),
          if (isExpired)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.red.withOpacity(0.85),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'EXPIRED',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  letterSpacing: 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}