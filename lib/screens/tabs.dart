import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

class TabsScreens extends StatefulWidget {
  const TabsScreens({super.key});

  @override
  State<TabsScreens> createState() => _TabsScreensState();
}

class _TabsScreensState extends State<TabsScreens> {
  int _currentScreenIndex = 0;
  final List<Meal> _favMeals = [];

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

  _selectScreen(int index) {
    setState(() {
      _currentScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = Categories(
      onToggleFav: _toggleMealFavStatus,
    );
    String activeScreenTitle = 'Categories';

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
