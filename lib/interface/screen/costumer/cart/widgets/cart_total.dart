import 'package:flutter/material.dart';
import '../../../../../domain/providers-customer/cart_provider.dart';
// import '../../../../../domain/providers/cart_provider.dart';
import '../../../../component/widgets/costumer widget/pizza_button.dart';

class CartTotalWidget extends StatelessWidget {
  final double totalAmount;
  final List<CartItem> cartItems;
  final VoidCallback onCheckout;

  const CartTotalWidget({
    super.key,
    required this.totalAmount,
    required this.cartItems,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30), // Added rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Displaying the total price
            Text(
              "Total: \$${totalAmount.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Replacing the ElevatedButton with PizzaButton
            PizzaButton(
              label: 'Checkout',
              onPressed: onCheckout, // This will handle the checkout logic
              type: 'primary', // Set the type to primary to match the button style
              icon: Icons.check_circle_outline, // Optional icon
            ),
          ],
        ),
      ),
    );
  }
}
