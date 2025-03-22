import '../model/costumer model/categories.dart';
import '../model/costumer model/food.dart';

class ProductData {
  static List<Food> getFoods() {
    // This is a sample implementation - you'll need to update this with your actual data
    return [
      Food(
        id: 1,
        name: "Margherita Pizza",
        description: "Classic pizza with tomato sauce, mozzarella, and basil",
        price: 9.99,
        image: "https://example.com/margherita.jpg",
      ),
      Food(
        id: 2,
        name: "Pepperoni Pizza",
        description: "Pizza with tomato sauce, mozzarella, and pepperoni",
        price: 11.99,
        image: "https://example.com/pepperoni.jpg",
      ),
      // Add more food items as needed
    ];
  }

  static List<Category> getCategories() {
    return [
      Category(
        id: "1",
        name: "Pizza",
        description: "Delicious pizza options",
      ),
      Category(
        id: "2",
        name: "Drinks",
        description: "Refreshing beverages",
      ),
      Category(
        id: "3",
        name: "Combos",
        description: "Value meal combinations",
      ),
      Category(
        id: "4",
        name: "Discounts",
        description: "Special offers and discounts",
      ),
      Category(
        id: "5",
        name: "Desserts",
        description: "Sweet treats to finish your meal",
      ),
    ];
  }
}

