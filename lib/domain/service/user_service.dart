import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user.dart';
import '../../env/environment.dart';

class UserService {
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('${Environment.API_URL}users'));

    if (response.statusCode == 200) {
      // Decode the response body
      final Map<String, dynamic> body = json.decode(response.body);

      // Check if 'data' exists and is a List
      if (body.containsKey('data') && body['data'] is List) {
        List<dynamic> userList = body['data'];
        return userList.map((item) => User.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> fetchUserById(int id) async {
    final response = await http.get(Uri.parse('${Environment.API_URL}users/$id'));

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }
}


void main(){
  UserService().fetchUsers().then((users) {
    for (var user in users) {
      print(user.toJson());
    }
  });
}