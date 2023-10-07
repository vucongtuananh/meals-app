import 'package:flutter_riverpod/flutter_riverpod.dart';

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
