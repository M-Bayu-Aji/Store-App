import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/models/carts.dart';

class CartsService {
  final String apiUrl = "https://fakestoreapi.com/";

  // Get all carts
  Future<List<UserCart>> fetchCarts() async {
    try {
      final url = Uri.parse('${apiUrl}carts');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => UserCart.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load carts: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching carts: $e');
      rethrow;
    }
  }

  // Get cart by user ID
  Future<List<UserCart>> fetchUserCarts(int userId) async {
    try {
      final url = Uri.parse('${apiUrl}carts/user/$userId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => UserCart.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load user carts: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching user carts: $e');
      rethrow;
    }
  }

  // Add new cart
  Future<UserCart> addCart(int userId, List<CartProduct> products) async {
    try {
      final url = Uri.parse('${apiUrl}carts');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'date': DateTime.now().toIso8601String(),
          'products': products.map((p) => p.toJson()).toList(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint('Cart added successfully: $data');
        // API returns the created cart, but might not have all fields
        // So we create a UserCart object manually
        return UserCart(
          id: data['id'] ?? 0,
          userId: userId,
          date: DateTime.now(),
          products: products,
        );
      } else {
        throw Exception('Failed to add cart: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error adding cart: $e');
      rethrow;
    }
  }

  // Get user data
  Future<UserData> fetchUser(int userId) async {
    try {
      final url = Uri.parse('${apiUrl}users/$userId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserData.fromJson(data);
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching user: $e');
      rethrow;
    }
  }
}