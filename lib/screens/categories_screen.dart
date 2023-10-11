import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_screen.dart';
import 'package:meals_app/widgets/category_grid_items.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeal});

  final List<Meal> availableMeal;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _positionOffset;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500), lowerBound: 0, upperBound: 1);
    _positionOffset = Tween<Offset>(begin: const Offset(0, 0.3), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));

    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeal.where((meal) => meal.categories.contains(category.id)).toList();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealScreen(
            title: category.title,
            meals: filteredMeals,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.5, crossAxisSpacing: 20, mainAxisSpacing: 20),
          children: availableCategories.map((e) {
            return CategoryGridItem(
              category: e,
              onselectCategory: () {
                _selectCategory(context, e);
              },
            );
          }).toList()),
      builder: (context, child) {
        return SlideTransition(
          position: _positionOffset,
          child: child,
        );
      },
    );
  }
}
