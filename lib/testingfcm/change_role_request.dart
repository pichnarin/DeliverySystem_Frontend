import 'package:dio/dio.dart';
import 'package:frontend/env/environment.dart';
import 'package:frontend/env/user_local_storage/secure_storage.dart';

Future<void> changeRoleRequest(String requestedRole) async {
  Dio dio = Dio();

  // Ensure the token is retrieved
  final token = await secureLocalStorage.retrieveToken();
  if (token == null || token.isEmpty) {
    print("Error: Token is missing or invalid.");
    return;
  }

  try {
    print("Token: $token"); // Log the token for debugging

    // Make the request to change the role
    Response response = await dio.post(
      '${Environment.endpointApi}/requestRoleChange', // Make sure the endpoint is correct
      data: {
        "requested_role": requestedRole, // Either 'driver' or 'customer'
      },
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );

    print("Response status: ${response.statusCode}");
    print("Response data: ${response.data}");

    // Check if the role change request was successful
    if (response.statusCode == 201) {
      print("Role change request submitted successfully: ${response.data}");
    } else {
      print("Failed to submit role change request: ${response.statusMessage}");
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
