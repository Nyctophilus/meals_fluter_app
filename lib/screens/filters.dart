import 'package:flutter/material.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/widgets/switch_item.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      // drawer: MainDrawer(onSelectScreen: (id) {
      //   Navigator.of(context).pop();
      //   if (id == 'meals') {
      //     Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (ctx) => const TabsScreens()));
      //   }
      // }),
      body: Column(children: const [
        SwitchItem(
          title: 'Gluten-free',
          subtitle: 'Only include gluten free meals.',
          filter: Filter.isGlutenFree,
        ),
        SwitchItem(
          title: 'Lactose-free',
          subtitle: 'Only include lactose free meals.',
          filter: Filter.isLactoseFree,
        ),
        SwitchItem(
          title: 'Vegetarian',
          subtitle: 'Only include vegetarian meals.',
          filter: Filter.isVegetarian,
        ),
        SwitchItem(
          title: 'Vegan',
          subtitle: 'Only include vegan meals.',
          filter: Filter.isVegan,
        ),
      ]),
    );
  }
}
