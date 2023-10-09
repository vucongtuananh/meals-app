import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filter_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final filterValue = ref.watch(filterProvider);
    //use .watch if you need to change state whenever
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Screen"),
      ),
      body: Column(
        children: [
          SwitchListTile(
              value: filterValue[Filters.glutenFree]!,
              onChanged: (isChecked) {
                ref.read(filterProvider.notifier).setFilter(Filters.glutenFree, isChecked);
                //use read to change state once time
              },
              title: Text(
                "Gluten-free",
                style:
                    Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Only include gluten-free meals",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              )),
          SwitchListTile(
              value: filterValue[Filters.lactoseFree]!,
              onChanged: (isChecked) {
                ref.read(filterProvider.notifier).setFilter(Filters.lactoseFree, isChecked);
              },
              title: Text(
                "Lactose-free",
                style:
                    Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Only include gluten-free meals",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              )),
          SwitchListTile(
              value: filterValue[Filters.vegan]!,
              onChanged: (isChecked) {
                ref.read(filterProvider.notifier).setFilter(Filters.vegan, isChecked);
              },
              title: Text(
                "Vegan",
                style:
                    Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Only include vegan meals",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              )),
          SwitchListTile(
              value: filterValue[Filters.vegetarian]!,
              onChanged: (isChecked) {
                ref.read(filterProvider.notifier).setFilter(Filters.vegetarian, isChecked);
              },
              title: Text(
                "Vegatarian",
                style:
                    Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Only include vegetarian meals",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              )),
        ],
      ),
    );
  }
}
