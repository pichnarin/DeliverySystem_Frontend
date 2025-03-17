import 'package:http/http.dart' as http;
import 'api_service.dart';

void placeOrder() async {
  try {
    Map<String, dynamic> orderData = {
      "customer_id": 1,
      "address_id": 1,
      "food": [
        {"food_id": 11, "quantity": 3 },
        {"food_id": 12, "quantity": 10}
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

