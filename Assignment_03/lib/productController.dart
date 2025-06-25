import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/productModel.dart';
import 'utils/urls.dart';

class Productcontroller {
  List<Data> products = [];

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(Urls.readProduct));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ProductModel model = ProductModel.fromJson(data); // ✅ Fix here
      products = model.data ?? [];
    }
  }

  Future<void> createProduct({
    required String name,
    required String image,
    required int qty,
    required int unitPrice,
    required int totalPrice,
  }) async {
    final response = await http.post(
      Uri.parse(Urls.createProduct),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "Img": image,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice": totalPrice,
      }),
    );

    if (response.statusCode == 200) {
      await fetchProducts(); // Wait to fetch updated list
    } else {
      throw Exception("Failed to create product");
    }
  }

  Future<void> updateProduct({
    required String id,
    required String name,
    required String image,
    required int qty,
    required int unitPrice,
    required int totalPrice,
  }) async {
    final response = await http.put(
        Uri.parse(Urls.updateProduct(id)), // ← fix your URL endpoint
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "Img": image,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice": totalPrice,
      }),
    );

    if (response.statusCode == 200) {
      print(" Product updated");
      await fetchProducts();
    } else {
      print(" Failed to update product");
    }
  }

  Future<bool> DeleteProducts(String productId) async {
    final response = await http.get(Uri.parse(Urls.deleteProduct(productId)));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;

    }
    else{
      return false;
    }
  }

}
