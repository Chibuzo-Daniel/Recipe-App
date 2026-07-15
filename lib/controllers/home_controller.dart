import 'package:get/get.dart';
import '../models/recipe_model.dart';
import '../services/api_service.dart';

class HomeController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());

  // observble variables
  var currentTab = 0.obs;
  var recipes = <Recipe>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // fetch recipe when screen loads
    fetchRecipes();
  }

  //navigation tab
  void changeTab(int index) {
    currentTab(index);
  }

  // fetch the recipes from the api
  Future<void> fetchRecipes() async {
    try {
      isLoading(true);
      // Clear previous errors on retry
      errorMessage('');

      final fetchedRecipes = await _apiService.getRecipes();
      recipes.assignAll(fetchedRecipes);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
