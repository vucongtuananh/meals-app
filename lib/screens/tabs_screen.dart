import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorite_provider.dart';
import 'package:meals_app/providers/filter_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';
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

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _pageSelectedIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _pageSelectedIndex = index;
    });
  }

  void _onSelectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      await Navigator.of(context).push<Map<Filters, bool>>(MaterialPageRoute(
        //this generic type of .push<Map<Filters,bool>> is values we take from the filter screen
        builder: (context) => const FiltersScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(filterProvider);
    final meals = ref.watch(mealsProvider);
    List<Meal> filterMeal = meals.where(
      (meal) {
        if (filters[Filters.glutenFree]! && !meal.isGlutenFree) return false;
        if (filters[Filters.lactoseFree]! && !meal.isLactoseFree) return false;
        if (filters[Filters.vegetarian]! && !meal.isVegetarian) return false;
        if (filters[Filters.vegan]! && !meal.isVegan) return false;
        return true;
      },
    ).toList();
    Widget activePage = CategoriesScreen(
      availableMeal: filterMeal,
    );
    /* 
      Lỗi ngu như con lợn của Tuấn Anh : 
      Widget activePage đặt ở bên ngoài 
      -Lí do : 
        Khi chạy app, nó chỉ build những gì ở trong hàm build này thôi má!, nếu mày để ở ngoài hàm build thì nó sẽ mặc định chạy 1 cái đầu, xong không động đến widget nữa,
        nghĩa là cái activePage nó = CategoriesScreen đúng 1 phát đầu thôi, còn lại nó kh được set bằng cái gì khi _pageSelectedIndex = 1
    */
    String pageTitle = "Categories";
    if (_pageSelectedIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealProvider);
      activePage = MealScreen(
        //this I dont need create a new favorite screen, i can use the meal screen with different parameter meals!!
        meals: favoriteMeals,
      );
      pageTitle = "Favorite";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
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
