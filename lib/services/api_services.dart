import 'dart:convert';

import '../model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  String url = 'https://fakestoreapi.com/products';

  static ApiServices _instance = ApiServices._internal();
  factory ApiServices() {
    return _instance;
  }
  ApiServices._internal();

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

}