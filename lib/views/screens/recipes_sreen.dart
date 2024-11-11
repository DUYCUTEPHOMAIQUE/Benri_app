import 'dart:math';
import 'package:benri_app/utils/constants/colors.dart';
import 'package:benri_app/view_models/favourite_recipe_provider.dart';
import 'package:benri_app/views/screens/your_recipe_screen.dart';
import 'package:benri_app/views/widgets/app_bar.dart';
import 'package:benri_app/views/widgets/my_search_bar.dart';
import 'package:benri_app/views/widgets/recipe_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BAppBar(title: 'Recipe'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: MySearchBar(hintText: 'Search your favourite recipe'),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 12, left: 20),
              margin: EdgeInsets.symmetric(horizontal: 12),
              height: 180,
              decoration: BoxDecoration(
                  color: BColors.accent,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/deco/background_explore.png',
                      ),
                      fit: BoxFit.cover)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Get your Recipes",
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.grey[800]),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: BColors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Get started",
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Hot Today",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const Icon(
                        Icons.whatshot,
                        color: Colors.red,
                        size: 30,
                      )
                    ],
                  ),
                  Text(
                    "View More",
                    style: TextStyle(
                        color: Colors.blue[400], fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 264,
              // fixed height for horizontal list
              child: Consumer<FavouriteRecipeProvider>(
                builder: (context, value, child) {
                  final recipeMenu = value.recipes;
                  recipeMenu.shuffle();
                  final randomRecipeMenu = recipeMenu.take(10).toList();
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: randomRecipeMenu.length,
                    itemBuilder: (context, index) => RecipeTile(
                      recipe: randomRecipeMenu[index],
                      onTap: () => value.navigateToRecipeDetails(
                          context, randomRecipeMenu[index]),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Ensures space between the two sections
                children: [
                  // Left side: "Your recipe" and heart icon
                  Row(
                    children: [
                      Text(
                        "Your recipe",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  // Right side: "See All" button
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const YourRecipeScreen(), // Replace with your target page widget
                        ),
                      );
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                          color: Colors.blue[400], fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Consumer<FavouriteRecipeProvider>(
              builder: (context, value, child) {
                final favouriteRecipe = value.favouriteRecipes;
                if (favouriteRecipe.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "You dont have any favourite recipes\nPlease find more!!!",
                      style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: 264,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      // disable scrolling within list
                      itemCount: min(10, favouriteRecipe.length),
                      itemBuilder: (context, index) => RecipeTile(
                        recipe: favouriteRecipe[index],
                        onTap: () => value.navigateToRecipeDetails(
                            context, favouriteRecipe[index]),
                      ),
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "Highly Recommend",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const Icon(
                    Icons.whatshot,
                    color: Colors.red,
                    size: 30,
                  )
                ],
              ),
            ),
            Consumer<FavouriteRecipeProvider>(
              builder: (context, value, child) {
                final shuffedRecipes = value.recipes;
                shuffedRecipes.shuffle();
                final randomRecipes = shuffedRecipes
                    .take(min(shuffedRecipes.length, 10))
                    .toList();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 7,
                              mainAxisSpacing: 4,
                              childAspectRatio: 0.72),
                      itemCount: randomRecipes.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          child: Column(
                            children: [
                              RecipeTile(
                                recipe: randomRecipes[index],
                                onTap: () => value.navigateToRecipeDetails(
                                  context,
                                  randomRecipes[index],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
