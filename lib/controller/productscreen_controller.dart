import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ufsmachinetest/model/singleproduct_model.dart';

class ProductscreenController with ChangeNotifier {
  ProductDetailModel? productobj;
  bool isloading = false;

  Future<void> fetchproduct({required int id}) async {
    isloading = true;
    notifyListeners();
    final url = Uri.parse("https://fakestoreapi.com/products/$id");
    var res = await http.get(url);
    if (res.statusCode == 200) {
      productobj = productDetailModelFromJson(res.body);
    } else {
      throw Exception("failed to load product");
    }
    isloading = false;
    notifyListeners();
  }
}
