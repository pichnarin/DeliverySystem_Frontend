import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/domain/model/addresses.dart';
import 'package:frontend/domain/service/location_service.dart';
import 'package:http/http.dart' as http;
import '../model/food.dart';
import 'api_service.dart';

class FoodService {

  Future<List<Food>> getFood() async {
    try {
      http.Response response = await apiService.get('foods/getAllFoods');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['data'];
        return jsonData.map((food) => Food.fromJson(food)).toList();
      } else {
        throw Exception('Failed to fetch foods: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  
  Future<List<Food>> getFoodByCategory(String category) async {
    try {
      http.Response response = await apiService.get('foods/category/$category');
      
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['data'];
        return jsonData.map((food) => Food.fromJson(food)).toList();
      } else {
        throw Exception('Failed to fetch foods: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
  
  
}

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final FoodService _foodService = FoodService();
  final LocationService _locationService = LocationService();

  late Future<List<Food>> _foodFuture;

  @override
  void initState() {
    super.initState();
    _foodFuture = _foodService.getFoodByCategory('pizza');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Food Menu")),
      body: FutureBuilder<List<Food>>(
        future: _foodFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No food items available."));
          }

          List<Food> foods = snapshot.data!;
          return ListView.builder(
            itemCount: foods.length,
            itemBuilder: (context, index) {
              Food food = foods[index];

              return ListTile(
                leading: _buildFoodImage(food.image),
                title: Text(food.name),
                subtitle: Text("\$${food.price.toStringAsFixed(2)}"),
              );
            },
          );
        },
      ),
    );
  }

  // Method to handle the fallback image if the URL is invalid or fails to load
  Widget _buildFoodImage(String imageUrl) {
    return Image.network(
      imageUrl,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // If image fails to load, show a fallback icon or image
        return const Icon(
          Icons.fastfood, // You can use any other icon or widget you prefer
          size: 50,
          color: Colors.grey,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}


void main() {
  runApp(const MaterialApp(home: FoodScreen()));
}