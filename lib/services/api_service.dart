import 'package:get/get.dart';
import '../models/recipe_model.dart';

class ApiService extends GetConnect {
  // get all the recipes from the api
  Future<List<Recipe>> getRecipes() async {
    final response = await get('https://dummyjson.com/recipes');
    
    if (response.status.hasError) {
      return Future.error('Failed to load recipes from server');
    } else {
      final List<dynamic> recipeData = response.body['recipes'] ?? [];
      return recipeData.map((json) => Recipe.fromJson(json)).toList();
    }
  }
}