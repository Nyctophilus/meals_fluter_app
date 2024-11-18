import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/drawer_main.dart';

class TabsScreens extends StatefulWidget {
  const TabsScreens({super.key});

  @override
  State<TabsScreens> createState() => _TabsScreensState();
}

class _TabsScreensState extends State<TabsScreens> {
  int _currentScreenIndex = 0;
  final List<Meal> _favMeals = [];
  Map<Filter, bool> _selectedFilters = {
    Filter.isGlutenFree: false,
    Filter.isLactoseFree: false,
    Filter.isVegetarian: false,
    Filter.isVegan: false,
  };

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavStatus(Meal meal) {
    final isExisting = _favMeals.contains(meal);

    setState(() {
      if (isExisting) {
        _favMeals.remove(meal);
        _showInfoMessage('Meal is no longer a favorite.');
      } else {
        _favMeals.add(meal);
        _showInfoMessage('Added to your favorites successfully!');
      }
    });
  }

  void _selectScreen(int index) {
    setState(() {
      _currentScreenIndex = index;
    });
  }

  void _setScreen(String id) async {
    Navigator.of(context).pop();
    if (id == 'filters') {
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
              builder: (ctx) => FiltersScreen(
                    currentFilters: _selectedFilters,
                  )));

      setState(() {
        _selectedFilters = result ?? _selectedFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availabeMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.isGlutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.isLactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.isVegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilters[Filter.isVegetarian]! && !meal.isVegetarian) {
        return false;
      }

      return true;
    }).toList();

    String activeScreenTitle = 'Categories';
    Widget activeScreen = Categories(
      onToggleFav: _toggleMealFavStatus,
      availabeMeals: availabeMeals,
    );

    if (_currentScreenIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favMeals,
        onToggleFav: _toggleMealFavStatus,
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
