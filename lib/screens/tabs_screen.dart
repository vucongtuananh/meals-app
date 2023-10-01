import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _pageSelectedIndex = 0;

  Map<Filters, bool> _selectedFilters = kInitialFilters;

  void _selectPage(int index) {
    setState(() {
      _pageSelectedIndex = index;
    });
  }

  void _onSelectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      final result = await Navigator.of(context).push<Map<Filters, bool>>(MaterialPageRoute(
        builder: (context) => const FiltersScreen(),
      ));
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  final List<Meal> _favoriteMeals = [];

  void _showInforMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final _isExisting = _favoriteMeals.contains(meal);
    if (_isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInforMessage("Meal is no longer a favorite!");
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInforMessage("Meal is marked as a favorite!!");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Meal> filterMeal = dummyMeals.where(
      (meal) {
        if (_selectedFilters[Filters.glutenFree]! && !meal.isGlutenFree) return false;
        if (_selectedFilters[Filters.lactoseFree]! && !meal.isLactoseFree) return false;
        if (_selectedFilters[Filters.vegetarian]! && !meal.isVegetarian) return false;
        if (_selectedFilters[Filters.vegan]! && !meal.isVegan) return false;
        return true;
      },
    ).toList();
    Widget activePage = CategoriesScreen(
      toggleMealFavoriteStatus: _toggleMealFavoriteStatus,
      availableMeal: filterMeal,
    );
    /* 
      Lỗi ngu như con lợn của Tuấn Anh : 
      Widget activePage đặt ở bên ngoài 
      -Lí do : 
        Khi chạy app, nó chỉ build những gì ở trong hàm build này thôi má!, nếu mày để ở ngoài hàm build thì nó sẽ mặc định chạy 1 cái đầu, xong không động đến widget nữa,
        nghĩa là cái activePage nó = CategoriesScreen đúng 1 phát đầu thôi, còn lại nó kh được set bằng cái gì khi _pageSelectedIndex = 1
    */
    String _pageTitle = "Categories";
    if (_pageSelectedIndex == 1) {
      activePage = MealScreen(
        meals: _favoriteMeals,
        toggleMealFavoriteStatus: _toggleMealFavoriteStatus,
      );
      _pageTitle = "Favorite";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _onSelectScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _pageSelectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favortie")
        ],
      ),
    );
  }
}
