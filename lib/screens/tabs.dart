import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/drawer_main.dart';

class TabsScreens extends ConsumerStatefulWidget {
  const TabsScreens({super.key});

  @override
  ConsumerState<TabsScreens> createState() => _TabsScreensState();
}

class _TabsScreensState extends ConsumerState<TabsScreens> {
  int _currentScreenIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      _currentScreenIndex = index;
    });
  }

  void _setScreen(String id) async {
    Navigator.of(context).pop();
    if (id == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeals = ref.watch(filteredMealsList);

    String activeScreenTitle = 'Categories';
    Widget activeScreen = Categories(
      availabeMeals: filteredMeals,
    );

    if (_currentScreenIndex == 1) {
      final favMeals = ref.watch(favoriteMealsProvider);
      activeScreen = MealsScreen(
        meals: favMeals,
      );
      activeScreenTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreenTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        currentIndex: _currentScreenIndex,
        backgroundColor: Theme.of(context).colorScheme.background,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
