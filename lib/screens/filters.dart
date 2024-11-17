import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;

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
      body: Column(children: [
        SwitchListTile(
          value: _glutenFreeFilterSet,
          onChanged: (isCheck) {
            setState(() {
              _glutenFreeFilterSet = isCheck;
            });
          },
          title: Text(
            'Gluten-free',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            'Only include gluten free meals.',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
        )
      ]),
    );
  }
}
