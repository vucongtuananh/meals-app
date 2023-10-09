import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filters { glutenFree, lactoseFree, vegetarian, vegan }

class FilterProvider extends StateNotifier<Map<Filters, bool>> {
  FilterProvider()
      : super({
          Filters.glutenFree: false,
          Filters.lactoseFree: false,
          Filters.vegetarian: false,
          Filters.vegan: false,
        });
  void setFilters(Map<Filters, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filters filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterProvider = StateNotifierProvider<FilterProvider, Map<Filters, bool>>((ref) => FilterProvider());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filterProvider);
  return meals.where(
    (meal) {
      if (filters[Filters.glutenFree]! && !meal.isGlutenFree) return false;
      if (filters[Filters.lactoseFree]! && !meal.isLactoseFree) return false;
      if (filters[Filters.vegetarian]! && !meal.isVegetarian) return false;
      if (filters[Filters.vegan]! && !meal.isVegan) return false;
      return true;
    },
  ).toList();
});
