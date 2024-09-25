import 'package:flutter/material.dart';

class Recipe {
  final String name;
  final String ingredients;
  final String instructions;

  Recipe(this.name, this.ingredients, this.instructions);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<Recipe>> _loadRecipes(BuildContext context) async {
    List<Map<String, dynamic>> recipes = [
      {
        'name': 'Vegan Buddha Bowl',
        'ingredients':
            '1. Quinoa\n2. Sweet potato\n3. Avocado\n4. Kale\n5. Tahini sauce\n6. Chickpeas\n7. Olive oil',
        'instructions':
            '1. Roast sweet potatoes and chickpeas with olive oil.\n2. Cook quinoa according to package instructions.\n3. Arrange all ingredients in a bowl with avocado and kale.\n4. Drizzle with tahini sauce. Serve.',
      },
      {
        'name': 'Shrimp Tacos',
        'ingredients':
            '1. Shrimp\n2. Corn tortillas\n3. Red cabbage\n4. Avocado\n5. Lime\n6. Cilantro\n7. Chipotle mayo',
        'instructions':
            '1. Cook shrimp in a pan with olive oil.\n2. Warm tortillas.\n3. Top with cabbage, shrimp, avocado, and chipotle mayo.\n4. Squeeze lime and garnish with cilantro. Serve.',
      },
      {
        'name': 'Avocado Toast',
        'ingredients':
            '1. Avocado\n2. Bread\n3. Lemon\n4. Olive oil\n5. Red pepper flakes',
        'instructions':
            '1. Toast the bread.\n2. Mash avocado with lemon juice, olive oil, salt, and pepper.\n3. Spread avocado mixture on toast.\n4. Sprinkle with red pepper flakes. Serve.',
      },
      {
        'name': 'Blueberry Pancakes',
        'ingredients':
            '1. Flour\n2. Eggs\n3. Milk\n4. Blueberries\n5. Maple syrup\n6. Butter',
        'instructions':
            '1. Mix flour, eggs, and milk to create pancake batter.\n2. Fold in blueberries.\n3. Cook pancakes in a buttered pan until golden.\n4. Serve with maple syrup and extra blueberries.',
      },
      {
        'name': 'Quinoa Salad',
        'ingredients':
            '1. Quinoa\n2. Cucumber\n3. Tomato\n4. Feta cheese\n5. Lemon\n6. Olive oil',
        'instructions':
            '1. Cook quinoa and let cool.\n2. Chop cucumber and tomato.\n3. Toss with quinoa, feta, olive oil, and lemon juice. Serve chilled.',
      },
    ];
    return recipes
        .map((data) => Recipe(
              data['name'],
              data['ingredients'],
              data['instructions'],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modern Recipe Book'),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _loadRecipes(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final List<Recipe> recipes = snapshot.data ?? [];
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
              ),
              itemCount: recipes.length,
              itemBuilder: (BuildContext context, int index) {
                final recipe = recipes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: {'recipe': recipe},
                    );
                  },
                  child: Card(
                    elevation: 3.0,
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.grey.shade400,
                    child: Center(
                      child: Text(
                        recipe.name,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
