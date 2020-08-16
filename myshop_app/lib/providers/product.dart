import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:myshop_app/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _resetFavoriteValue(bool oldFavoriteValue) {
    isFavorite = oldFavoriteValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String authToken, String userId) async {
    final url =
        "https://my-shop-flutter-3719c.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken";
    final oldFavoriteValue = isFavorite;

    isFavorite = !isFavorite;
    notifyListeners();
    try {
      // final response = await http.patch(
      final response = await http.put(
        url,
        body: json.encode(
          {"isFavorite": isFavorite},
        ),
      );
      if (response.statusCode >= 400) {
        _resetFavoriteValue(oldFavoriteValue);
        throw HttpException("Failed");
      }
    } catch (error) {
      _resetFavoriteValue(oldFavoriteValue);
    }
  }
}
