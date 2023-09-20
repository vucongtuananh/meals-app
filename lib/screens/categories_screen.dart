import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/meal_screen.dart';
import 'package:meals_app/widgets/category_grid_items.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals.where((meal) => meal.categories.contains(category.id)).toList();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealScreen(title: category.title, meals: filteredMeals),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.5, crossAxisSpacing: 20, mainAxisSpacing: 20),
        children: availableCategories.map((e) {
          return CategoryGridItem(
            category: e,
            onselectCategory: () {
              _selectCategory(context, e);
            },
          );
        }).toList());
  }
}
