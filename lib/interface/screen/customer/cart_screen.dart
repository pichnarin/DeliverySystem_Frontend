import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/provider/address_provider.dart';
import '../../../domain/provider/cart_provider.dart';
import '../../../domain/service/order_service.dart';
import 'addresses_list_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  final OrderService orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final addressProvider = Provider.of<AddressProvider>(context);
    var selectedAddressId = addressProvider.address.keys.isEmpty
        ? null
        : addressProvider.address.keys.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty
                ? const Center(child: Text('Your cart is empty'))
                : ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, index) {
                final foodId = cart.items.keys.toList()[index];
                final quantity = cart.items.values.toList()[index];
                return ListTile(
                  title: Text('Food ID: $foodId'),
                  subtitle: Text('Quantity: $quantity'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      cart.removeFromCart(foodId);
                    },
                  ),
                );
              },
            ),
          ),
          // Address Section
          ListTile(
            title: Text(
              selectedAddressId != null
                  ? 'Address ID: $selectedAddressId'
                  : 'No address selected',
            ),
            trailing: TextButton(
              child: const Text('Select Address'),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddressListScreen()),
                );

                if (result != null) {
                  setState(() {
                    selectedAddressId = result;
                  });
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: const Text('Place Order'),
              onPressed: () async {
                if (selectedAddressId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select an address!')),
                  );
                  return;
                }

                // ✅ Key fixed here:
                final orderData = {
                  "address_id": selectedAddressId,
                  "food": cart.getOrderData(), // FIXED: was cartProvider.getOrderData()
                };
                await orderService.placeOrder(orderData);

                cart.clearCart();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order Placed Successfully')),
                );

                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
