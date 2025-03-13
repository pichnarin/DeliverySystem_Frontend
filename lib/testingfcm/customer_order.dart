import 'package:dio/dio.dart';
import 'package:frontend/env/environment.dart';
import 'package:frontend/env/user_local_storage/secure_storage.dart';

Future<void> placeOrder(int customerId, int addressId, List<Map<String, dynamic>> food, String paymentMethod) async {
  Dio dio = Dio();

  // Ensure the token is retrieved
  final token = await secureLocalStorage.retrieveToken();
  if (token == null || token.isEmpty) {
    print("Error: Token is missing or invalid.");
    return;
  }

  try {
    print("Token: $token"); // Log the token for debugging

    // Make the request to place the order
    Response response = await dio.post(
      '${Environment.endpointApi}/orders',
      data: {
        "customer_id": customerId,
        "address_id": addressId,
        "food": food,
        "payment_method": paymentMethod,
      },
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    print("Response status: ${response.statusCode}");
    print("Response data: ${response.data}");

    // Check if the order was placed successfully
    if (response.statusCode == 201) {
      print("Order placed successfully: ${response.data}");
    } else {
      print("Failed to place order: ${response.statusMessage}");
    }
  } catch (e) {
    // Handle any error during the request
    if (e is DioError) {
      print("DioError: ${e.response?.statusCode}, ${e.message}");
    } else {
      print("Error: $e");
    }
  }
}