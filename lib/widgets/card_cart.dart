import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_akhir_mandiri_pplgxii5/models/store.dart';

class CardCart extends StatelessWidget {
  final Store product;
  final int quantity;
  final VoidCallback? onRemove;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const CardCart({
    super.key,
    required this.product,
    required this.quantity,
    this.onRemove,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error_outline);
                  },
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2C5F5D),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2C5F5D),
                  ),
                ),
                const SizedBox(height: 8),
                // Quantity Controls
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF7FA99B).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 16),
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(),
                            onPressed: onDecrement,
                            color: const Color(0xFF2C5F5D),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '$quantity',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF2C5F5D),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 16),
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(),
                            onPressed: onIncrement,
                            color: const Color(0xFF2C5F5D),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Delete Button
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.red,
                      onPressed: onRemove,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
