// api_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:test_task/model/category_model.dart';
import 'package:test_task/model/product_model.dart';
import 'package:test_task/utills/exception_hundle.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';
  // fetcch all categories
  Future<List<CategoryModel>> fetchCategories() async {
    final String endpoint = '/products/categories';
    final Uri url = Uri.parse('$baseUrl$endpoint');

    try {
      final http.Request request = http.Request('GET', url);
      final http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 10),
        onTimeout:
            () => throw ApiException('Request timed out after 10 seconds'),
      );

      if (response.statusCode == 200) {
        final String responseBody = await response.stream.bytesToString();
        logger.d(
          'Categories API Response: $responseBody',
        ); // Log the raw response
        final List<dynamic> categoriesJson =
            jsonDecode(responseBody) as List<dynamic>;
        return categoriesJson
            .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(
          'Failed to fetch categories: ${response.reasonPhrase}',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException('No internet connection. Please check your network.');
    } on FormatException {
      throw ApiException('Failed to parse response data.');
    } catch (e) {
      throw ApiException('An unexpected error occurred: ${e.toString()}');
    }
  }

  // Fetch products from the API with pagination

  Future<Map<String, dynamic>> fetchProducts({
    int limit = 10,
    int skip = 0,
  }) async {
    final String endpoint = '/products?limit=$limit&skip=$skip';
    final Uri url = Uri.parse('$baseUrl$endpoint');

    try {
      final http.Request request = http.Request('GET', url);
      final http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 10),
        onTimeout:
            () => throw ApiException('Request timed out after 10 seconds'),
      );

      if (response.statusCode == 200) {
        final String responseBody = await response.stream.bytesToString();
        logger.d(
          'API Response (skip=$skip): $responseBody',
        ); // Log the raw response
        final Map<String, dynamic> jsonData = jsonDecode(responseBody);
        final List<dynamic> productsJson =
            jsonData['products'] as List<dynamic>;
        final List<ProductModel> products =
            productsJson
                .map(
                  (json) => ProductModel.fromJson(json as Map<String, dynamic>),
                )
                .toList();
        return {
          'products': products,
          'total': jsonData['total'] as int,
          'skip': jsonData['skip'] as int,
          'limit': jsonData['limit'] as int,
        };
      } else {
        throw ApiException(
          'Failed to fetch products: ${response.reasonPhrase}',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException('No internet connection. Please check your network.');
    } on FormatException {
      throw ApiException('Failed to parse response data.');
    } catch (e) {
      throw ApiException('An unexpected error occurred: ${e.toString()}');
    }
  }

  // Fetch products from the API with pagination category filter
  Future<Map<String, dynamic>> fetchProductsByUrl({
    required String categoryUrl,
    int limit = 10,
    int skip = 0,
  }) async {
    // Append pagination parameters to the category URL
    final Uri url = Uri.parse('$categoryUrl?limit=$limit&skip=$skip');

    try {
      final http.Request request = http.Request('GET', url);
      final http.StreamedResponse response = await request.send().timeout(
        const Duration(seconds: 10),
        onTimeout:
            () => throw ApiException('Request timed out after 10 seconds'),
      );

      if (response.statusCode == 200) {
        final String responseBody = await response.stream.bytesToString();
        logger.d(
          'Products API Response (url=$categoryUrl, skip=$skip): $responseBody',
        );
        final Map<String, dynamic> jsonData = jsonDecode(responseBody);
        final List<dynamic> productsJson =
            jsonData['products'] as List<dynamic>;
        final List<ProductModel> products =
            productsJson
                .map(
                  (json) => ProductModel.fromJson(json as Map<String, dynamic>),
                )
                .toList();
        return {
          'products': products,
          'total': jsonData['total'] as int,
          'skip': jsonData['skip'] as int,
          'limit': jsonData['limit'] as int,
        };
      } else {
        throw ApiException(
          'Failed to fetch products: ${response.reasonPhrase}',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException('No internet connection. Please check your network.');
    } on FormatException {
      throw ApiException('Failed to parse response data.');
    } catch (e) {
      throw ApiException('An unexpected error occurred: ${e.toString()}');
    }
  }
}
