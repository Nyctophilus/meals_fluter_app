import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  isGlutenFree,
  isVegan,
  isVegetarian,
  isLactoseFree,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.isGlutenFree: false,
          Filter.isLactoseFree: false,
          Filter.isVegetarian: false,
          Filter.isVegan: false,
        });

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

// filter meals provider

final filteredMealsList = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[Filter.isGlutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.isLactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.isVegan]! && !meal.isVegan) {
      return false;
    }
    if (activeFilters[Filter.isVegetarian]! && !meal.isVegetarian) {
      return false;
    }

    return true;
  }).toList();
});
