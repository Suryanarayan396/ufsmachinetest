import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ufsmachinetest/model/allproduct_model.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  List<AllProductModel> _products = [];
  List<AllProductModel> get products => _products;

  Future<void> fetchallproducts() async {
    final response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _products = data
          .map(
            (json) => AllProductModel.fromJson(json),
          )
          .toList();
      notifyListeners();
    } else {
      throw Exception("failed to load products");
    }
  }
}
