import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isFav = ref.watch(favoriteMealsProvider).contains(meal);

    return Scaffold(
      appBar: AppBar(title: Text(meal.title), actions: [
        IconButton(
          onPressed: () {
            final wasAdded = ref
                .read(favoriteMealsProvider.notifier)
                .toggleMealsFavStatus(meal);

            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    wasAdded ? 'Meal added as favorite.' : 'Meal removed!')));
          },
          // icon: AnimatedSwitcher(
          //   duration: const Duration(milliseconds: 200),
          //   transitionBuilder: (child, animation) {
          //     return RotationTransition(
          //       turns: Tween(begin: 0.9, end: 1.0).animate(animation),
          //       child: child,
          //     );
          //   },
          //   child: Icon(
          //     isFav ? Icons.star : Icons.star_border_outlined,
          //     key: ValueKey(isFav),
          //   ),
          // ),
          icon: AnimatedCrossFade(
            firstChild: const Icon(Icons.star),
            secondChild: const Icon(Icons.star_border_outlined),
            crossFadeState:
                isFav ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 500),
          ),
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeInImage(
              image: NetworkImage(meal.imageUrl),
              placeholder: MemoryImage(kTransparentImage),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            const SizedBox(height: 32),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            for (final ing in meal.ingredients)
              Text(
                ing,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            const SizedBox(height: 24),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            for (final step in meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
