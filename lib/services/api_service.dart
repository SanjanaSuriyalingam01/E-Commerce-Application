import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import '../models/product.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  static String baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:5000';
  // Update if IP changes

  static Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/api/products'));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<Product> addProduct(
    String name,
    double price,
    String description,
    PlatformFile? image,
  ) async {
    var uri = Uri.parse('$baseUrl/api/products');
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = name;
    request.fields['price'] = price.toString();
    request.fields['description'] = description;

    if (image != null && image.bytes != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          image.bytes!,
          filename: image.name,
        ),
      );
    }

    var response = await request.send();
    if (response.statusCode == 201) {
      return Product.fromJson(
        jsonDecode(await response.stream.bytesToString()),
      );
    } else {
      throw Exception('Failed to add product');
    }
  }

  static Future<void> deleteProduct(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/api/products/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }

  static Future<Product> updateProduct(
    String id,
    String name,
    double price,
    String description,
    PlatformFile? image,
  ) async {
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('$baseUrl/api/products/$id'),
    );
    request.fields['name'] = name;
    request.fields['price'] = price.toString();
    request.fields['description'] = description;

    if (image != null && image.bytes != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          image.bytes!,
          filename: image.name,
        ),
      );
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      return Product.fromJson(
        jsonDecode(await response.stream.bytesToString()),
      );
    } else {
      throw Exception('Failed to update product');
    }
  }

  static Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/api/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email.trim(), 'password': password.trim()}),
      );
      return response.statusCode == 200;
    } catch (e, s) {
      debugPrint('❌ LOGIN ERROR → $e');
      debugPrintStack(stackTrace: s);
      return false;
    }
  }

  static Future<bool> signup(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email.trim(), 'password': password.trim()}),
      );
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}
