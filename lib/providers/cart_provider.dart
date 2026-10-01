import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  List<Product> _products = [];
  List<CartItem> _cartItems = [];

  List<Product> get products => _products;
  List<CartItem> get cartItems => _cartItems;

  double get totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  Future<void> fetchProductsAndCart() async {
    _products = await DBHelper.instance.getProducts();
    _cartItems = await DBHelper.instance.getCartItems();
    notifyListeners();
  }

  Future<void> addToCart(Product product) async {
    final index = _cartItems.indexWhere((item) => item.productId == product.id);
    if (index != -1) {
      final item = _cartItems[index];
      await updateQuantity(item.id!, 1);
    } else {
      final newItem = CartItem(
        productId: product.id!,
        name: product.name,
        price: product.price,
        quantity: 1,
        imageUrl: product.imageUrl,
      );
      await DBHelper.instance.insertCart(newItem);
      _cartItems = await DBHelper.instance.getCartItems();
      notifyListeners();
    }
  }

  Future<void> updateQuantity(int id, int change) async {
    final index = _cartItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      final currentItem = _cartItems[index];
      final newQuantity = currentItem.quantity + change;

      if (newQuantity <= 0) {
        await DBHelper.instance.deleteCartItem(id);
      } else {
        await DBHelper.instance.updateCartQuantity(id, newQuantity);
      }
      _cartItems = await DBHelper.instance.getCartItems();
      notifyListeners();
    }
  }
}