import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.mealTitle, required this.mealUrl});

  final String mealTitle;
  final String mealUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealTitle),
      ),
      body: Card(
        elevation: 2,
        child: FadeInImage(
          image: NetworkImage(mealUrl),
          placeholder: MemoryImage(kTransparentImage),
        ),
      ),
    );
  }
}
