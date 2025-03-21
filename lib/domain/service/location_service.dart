import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/domain/model/addresses.dart';
import 'package:http/http.dart' as http;

import 'api_service.dart';

class LocationService{
  Future<List<Addresses>> fetchAllAddress() async {
    try {
      http.Response response = await apiService.get('addresses');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['data'];
        return jsonData.map((address) => Addresses.fromJson(address)).toList();
      } else {
        throw Exception('Failed to fetch foods: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> createAddress(Addresses address) async {
    try {
      http.Response response = await apiService.post('/addresses/create', address.toJson());
      if (response.statusCode == 201) {
        response.body;
      } else {
        throw Exception('Failed to create address: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}



class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<LocationScreen> {
  final LocationService _foodService = LocationService();
  final LocationService _locationService = LocationService();

  late Future<List<Addresses>> _foodFuture;

  @override
  void initState() {
    super.initState();
    _foodFuture = _foodService.fetchAllAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Food Menu")),
      body: FutureBuilder<List<Addresses>>(
        future: _foodFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No food items available."));
          }

          List<Addresses> foods = snapshot.data!;
          return ListView.builder(
            itemCount: foods.length,
            itemBuilder: (context, index) {
              Addresses food = foods[index];

              return ListTile(
                leading: _buildFoodImage(food.latitude as String),
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
  runApp(const MaterialApp(home: LocationScreen()));
}