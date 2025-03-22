import 'package:flutter/material.dart';
import '../../../../../domain/providers-customer/cart_provider.dart';
// import '../../../../../domain/providers/cart_provider.dart';
import '../../../../../domain/utils/model_adapter.dart';
import '../../../../component/widgets/costumer widget/pizza_button.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final Function(String) removeFromCart;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.removeFromCart,
  });

  @override
  Widget build(BuildContext context) {
    // Use ModelAdapter to get the price for the selected size
    final itemPrice = ModelAdapter.getPriceForSize(item.food, item.size);
    final totalItemPrice = itemPrice * item.quantity;
    
    return ListTile(
      leading: Image.network(
        item.food.image, // Updated to use food.image instead of product.imageUrl
        width: 50, 
        height: 50, 
        fit: BoxFit.cover
      ),
      title: Text("${item.food.name} (${item.size})"), // Updated to use food.name
      subtitle: Text("Quantity: ${item.quantity}"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Price Display - using ModelAdapter to get the price
          Text("\$${totalItemPrice.toStringAsFixed(2)}"),
          const SizedBox(width: 10),
          
          // Replacing the IconButton with PizzaButton
          PizzaButton(
            label: 'Remove',
            onPressed: () {
              // Updated to use the new removeFromCart signature
              removeFromCart("${item.food.id}_${item.size}");
            },
            type: 'neutral',  // Neutral button style for remove
            icon: Icons.remove_circle_outline, // Optional icon for remove action
          ),
        ],
      ),
    );
  }
}

