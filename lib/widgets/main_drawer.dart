import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Row(
                children: [
                  const Icon(
                    Icons.fastfood,
                    size: 48,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Cooking up!",
                    style:
                        Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                  )
                ],
              )),
          ListTile(
            onTap: () {
              onSelectScreen('meals');
            },
            leading: const Icon(Icons.restaurant),
            title: Text(
              "Meals",
              style:
                  Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(
              "Filters",
              style:
                  Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            onTap: () {
              onSelectScreen('filters');
            },
          )
        ],
      ),
    );
  }
}
