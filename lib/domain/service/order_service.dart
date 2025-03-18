import 'package:http/http.dart' as http;
import 'api_service.dart';

void placeOrder() async {
  try {
    Map<String, dynamic> orderData = {
      "address_id": 2,
      "food": [
        {"food_id": 3, "quantity": 3 },
        {"food_id": 4, "quantity": 10}
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

void createAddress() async{
  try{
    Map<String, dynamic> addressData ={
      "latitude": 40.7128,
      "longitude": 74.0060,
      "reference": "Super Market",
      "city": "Phnom penh",
      "street": "123 Main St",
      "state": "PP",
      "zip": "10030"
    };

    http.Response response = await apiService.post("addresses/create-address", addressData);

    if(response.statusCode == 201){
      print("Address created successfully: ${response.body}");
    } else {
      print("Error ${response.statusCode}: ${response.body}");
    }
  }catch(e){
    print("Exception: $e");
  }
}