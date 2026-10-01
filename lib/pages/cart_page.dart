import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Saya'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.cartItems.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_cafe_outlined,
                      size: 70, color: Color(0xFFD2B48C)),
                  SizedBox(height: 12),
                  Text(
                    'Keranjang masih kosong nih.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF7A6B5D),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartProvider.cartItems[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFEFE9E2)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              width: 50,
                              height: 50,
                              color: const Color(0xFFF0EAE1),
                              child: const Icon(Icons.coffee,
                                  color: Color(0xFF8B5A2B)),
                            ),
                          ),
                        ),
                        title: Text(
                          item.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF332211),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          'Rp ${item.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Color(0xFF8B5A2B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline,
                                  color: Color(0xFF8B5A2B)),
                              onPressed: () =>
                                  cartProvider.updateQuantity(item.id!, -1),
                            ),
                            Text(
                              '${item.quantity}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF332211),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline,
                                  color: Color(0xFF8B5A2B)),
                              onPressed: () =>
                                  cartProvider.updateQuantity(item.id!, 1),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF4A3525),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 8),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Pembayaran',
                      style: TextStyle(color: Color(0xFFD2B48C), fontSize: 14),
                    ),
                    Text(
                      'Rp ${cartProvider.totalPrice.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}