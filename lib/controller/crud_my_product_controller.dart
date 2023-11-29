import 'dart:convert';
import 'package:alorferi_app_practice/controller/log_in_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CrudController extends GetxController {
  var products = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;

  var loginController = Get.find<LogInController>();

  static const String apiUrl = "https://demo.alorferi.com/api/my-products";

  @override
  void onInit(){
    super.onInit();
    getMyProducts();
  }

  Future<void> getMyProducts() async {
    var token = loginController.token;
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      isLoading.value = false;
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> productData = responseData['data'];
        products.value = List.from(productData);
        print("Product fetch successful");
      }else {
        print("Products fetch failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }



  Future<void> createProduct(Map<String, dynamic> product) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create product');
    }
  }




  Future<void> updateProduct(String id, Map<String, dynamic> updatedProduct) async {
    var token = loginController.token;
    final response = await http.post(
      Uri.parse('$apiUrl/$id?_method=put'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization" : "Bearer $token",
      },
      body: json.encode(updatedProduct),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }



  Future<void> deleteProduct(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete product');
    }
  }
}
