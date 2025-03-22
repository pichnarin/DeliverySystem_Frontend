import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../../../../domain/model/food.dart';
import '../../../../domain/model/costumer model/food.dart';
import '../../../../domain/providers-customer/cart_provider.dart';
// import '../../../../domain/providers/cart_provider.dart';
// import '../../../../providers/cart_provider.dart';

class SizeSelectionScreen extends StatefulWidget {
  final Food food;

  const SizeSelectionScreen({super.key, required this.food});

  @override
  State<SizeSelectionScreen> createState() => _SizeSelectionScreenState();
}

class _SizeSelectionScreenState extends State<SizeSelectionScreen> {
  String _selectedSize = 'S';
  int _selectedQuantity = 1;

  final Map<String, dynamic> sizeDetails = {
    'S': {'label': 'Small', 'price': 0.0},
    'M': {'label': 'Medium', 'price': 2.0},
    'L': {'label': 'Large', 'price': 4.0},
  };

  @override
  Widget build(BuildContext context) {
    final basePrice = widget.food.price;
    final selectedSizePrice = sizeDetails[_selectedSize]!['price'] as double;
    final totalPrice = basePrice + selectedSizePrice;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Size and Quantity"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display the image of the selected food
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(widget.food.image), // Updated to use food.image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Title text showing the food name
            Text(
              widget.food.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Size selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: sizeDetails.keys.map((size) {
                return ChoiceChip(
                  label: Text(sizeDetails[size]!['label']),
                  selected: _selectedSize == size,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedSize = size;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Quantity selection
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_selectedQuantity > 1) {
                        _selectedQuantity--;
                      }
                    });
                  },
                ),
                Text('$_selectedQuantity', style: const TextStyle(fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _selectedQuantity++;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Total price display
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Add to cart button
            ElevatedButton(
              onPressed: () {
                // Use _selectedQuantity here when adding to cart
                Provider.of<CartProvider>(context, listen: false).addToCart(
                  widget.food, // Pass food
                  _selectedSize,  // Pass selected size
                  _selectedQuantity,  // Pass selected quantity
                );

                // Show a confirmation message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Added ${widget.food.name} ($_selectedSize) to cart")),
                );
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}

