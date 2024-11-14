import 'package:flutter/material.dart';
import 'package:ufsmachinetest/model/allproduct_model.dart';

class BottomSheetController with ChangeNotifier {
  TextEditingController producttitlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController categorycontroller = TextEditingController();

//   Future<void> addproduct({
//     required String title,
//     required String des,
//     required int price,
//     required String categry,
//     required List<dynamic> products
//   }) async {
//     final newproduct=AllProductModel(title: title,description: des,price: price,);
//   }
// }
}
