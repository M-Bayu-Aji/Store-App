import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:shopping_app/models/store.dart';
import 'package:http/http.dart' as http;

class StoreService {
  final String apiUrl = "https://fakestoreapi.com/";

  Future<Store> fetchStore(String endPoint) async {
    try {
      final url = Uri.parse(apiUrl + endPoint);
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('Fetched data: $data');
        return Store.fromJson(data);
      } else {
        throw Exception('Failed to load store data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching store: $e');
      rethrow;
    }
  }

  Future<List<Store>> fetchStores(String endPoint) async {
    try {
      final url = Uri.parse(apiUrl + endPoint);
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data.map((json) => Store.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load stores: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching stores: $e');
      rethrow;
    }
  }
}
