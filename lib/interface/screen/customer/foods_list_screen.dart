import 'package:flutter/material.dart';
import 'package:frontend/domain/model/food.dart';
import 'package:frontend/domain/service/food_service.dart';
import 'package:provider/provider.dart';
import '../../../domain/provider/cart_provider.dart';
import 'cart_screen.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key});

  @override
  FoodListScreenState createState() => FoodListScreenState();
}

class FoodListScreenState extends State<FoodListScreen> {
  final FoodService _foodService = FoodService();

  late Future<List<Food>> foodList;


  @override
  void initState() {
    super.initState();
   foodList = _foodService.fetchAllFoods();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Foods'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Food>>(
        future: foodList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final foods = snapshot.data!;
          return ListView.builder(
            itemCount: foods.length,
            itemBuilder: (ctx, index) {
              final food = foods[index];
              return ListTile(
                leading: food.image.isNotEmpty
                    ? Image.network(
                  food.image,
                  width: 50,
                  errorBuilder: (context, error, stackTrace) {
                    // Display default icon/image when error
                    return const Icon(Icons.fastfood, size: 40);
                  },
                )
                    : const Icon(Icons.fastfood, size: 40), // When image URL is empty
                title: Text(food.name),
                subtitle: Text('\$${food.price.toStringAsFixed(2)}'),
                trailing: ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () {
                    cart.addToCart(food.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to Cart')),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
