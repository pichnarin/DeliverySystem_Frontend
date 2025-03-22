import 'package:flutter/material.dart';
import '../../../../../domain/model/costumer model/food.dart';
// import '../../../../../domain/model/food.dart';
import '../../../../component/widgets/costumer widget/product_card.dart';

class ProductGridView extends StatelessWidget {
  final List<Food> filteredProducts;
  final Function(BuildContext, Food) onProductTap;

  const ProductGridView({
    Key? key,
    required this.filteredProducts,
    required this.onProductTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onProductTap(context, filteredProducts[index]),
            child: ProductCard(food: filteredProducts[index]), // Updated to use food instead of product
          );
        },
      ),
    );
  }
}
