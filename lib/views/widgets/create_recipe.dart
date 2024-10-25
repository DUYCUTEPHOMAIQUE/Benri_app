import 'package:benri_app/utils/constants/colors.dart';
import 'package:benri_app/view_models/favourite_recipe_provider.dart';
import 'package:benri_app/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateRecipe extends StatelessWidget {
  const CreateRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController timeCookingController = TextEditingController();
    final TextEditingController ratingController = TextEditingController();

    return Scaffold(
      appBar: BAppBar(title: 'Create Recipe'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  label: const Text('Your recipe name'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: ratingController,
                decoration: InputDecoration(
                  label: const Text('Your rating'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: timeCookingController,
                decoration: InputDecoration(
                  label: const Text('Time Cooking'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  label: const Text('Description'),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
                minLines: 5,
                maxLines: null,
              ),
              const SizedBox(height: 16),

              // Use Consumer to show image or default text
              Consumer<FavouriteRecipeProvider>(
                builder: (context, recipeProvider, child) {
                  return Column(
                    children: [
                      // Display selected image or default message
                      if (recipeProvider.imageFile != null)
                        Image.file(
                          recipeProvider.imageFile!,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        )
                      else
                        const Text('No image selected'),
                      const SizedBox(height: 16),
                      // Buttons to pick an image or capture one
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => context
                                .read<FavouriteRecipeProvider>()
                                .pickImageFromGallery(),
                            icon: const Icon(Icons.photo_library),
                            label: const Text('Pick from Gallery'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: BColors.accent,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => context
                                .read<FavouriteRecipeProvider>()
                                .captureImageWithCamera(),
                            icon: const Icon(Icons.camera_alt),
                            label: const Text('Take a Photo'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: BColors.accent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Button to save recipe
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BColors.accent,
                        ),
                        onPressed: () {
                          if (nameController.text.isNotEmpty &&
                              timeCookingController.text.isNotEmpty &&
                              ratingController.text.isNotEmpty) {
                            context
                                .read<FavouriteRecipeProvider>()
                                .addNewRecipe(
                                  nameController.text,
                                  descriptionController.text,
                                  timeCookingController.text,
                                  ratingController.text,
                                );
                            Navigator.of(context)
                                .pop(); // Return to the previous screen
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Please fill all the text fields')),
                            );
                          }
                        },
                        child: const Text('Add New Recipe'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
