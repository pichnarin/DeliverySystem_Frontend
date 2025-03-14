import 'package:http/http.dart' as http;
import '../domain/service/api_service.dart';

void placeOrder() async {
  try {
    Map<String, dynamic> orderData = {
      "customer_id": 1,
      "address_id": 3,
      "food": [
        {"food_id": 8, "quantity": 2},
        {"food_id": 2, "quantity": 1}
      ]
    };

    http.Response response = await apiService.post("orders/place-orders", orderData);

    if (response.statusCode == 201) {
      print("Order placed successfully: ${response.body}");
    } else {
      print("Error ${response.statusCode}: ${response.body}");
    }
  } catch (e) {
    print("Exception: $e");
  }
}

