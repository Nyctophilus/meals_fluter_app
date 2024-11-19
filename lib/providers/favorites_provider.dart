import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealsFavStatus(Meal meal) {
    final isFav = state.contains(meal);

    if (isFav) {
      // remove it (it's already in the fav list)
      state = state.where((m) => m.id != meal.id).toList();

      return false;
    } else {
      // add it (it's not in the fav list)
      state = [...state, meal];

      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
        (ref) => FavoriteMealsNotifier());
