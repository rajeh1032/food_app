
abstract class ApiEndpoints {
  // ==================== BASE URLS ====================


  /// Using test API key '1' for development
  static const String mealDbBaseUrl = "https://www.themealdb.com/api/json/v1/1";

  /// Test API Key (for development and educational use)
  /// Replace with production key before releasing to app stores
  static const String apiKey = "1";

  // ==================== SEARCH ENDPOINTS ====================

  /// Search meal by name
  /// Example: /search.php?s=Arrabiata
  /// Returns: List of meals matching the search term
  static const String searchMealByName = "$mealDbBaseUrl/search.php";

  /// List all meals by first letter
  /// Example: /search.php?f=a
  /// Returns: List of meals starting with the specified letter
  static const String searchMealByFirstLetter = "$mealDbBaseUrl/search.php";

  // ==================== LOOKUP ENDPOINTS ====================

  /// Lookup full meal details by id
  /// Example: /lookup.php?i=52772
  /// Returns: Full details of a specific meal
  static const String lookupMealById = "$mealDbBaseUrl/lookup.php";

  /// Lookup a single random meal
  /// Example: /random.php
  /// Returns: A random meal with full details
  static const String randomMeal = "$mealDbBaseUrl/random.php";

  // ==================== CATEGORIES ENDPOINTS ====================

  /// List all meal categories
  /// Example: /categories.php
  /// Returns: List of all meal categories with images and descriptions
  static const String allCategories = "$mealDbBaseUrl/categories.php";

  // ==================== LIST ENDPOINTS ====================

  /// List all categories (names only)
  /// Example: /list.php?c=list
  /// Returns: Simple list of category names
  static const String listCategories = "$mealDbBaseUrl/list.php?c=list";

  /// List all areas/cuisines (names only)
  /// Example: /list.php?a=list
  /// Returns: Simple list of area/cuisine names
  static const String listAreas = "$mealDbBaseUrl/list.php?a=list";

  /// List all ingredients (names only)
  /// Example: /list.php?i=list
  /// Returns: Simple list of ingredient names
  static const String listIngredients = "$mealDbBaseUrl/list.php?i=list";

  // ==================== FILTER ENDPOINTS ====================

  /// Filter by main ingredient
  /// Example: /filter.php?i=chicken_breast
  /// Returns: List of meals containing the specified ingredient
  static const String filterByIngredient = "$mealDbBaseUrl/filter.php";

  /// Filter by category
  /// Example: /filter.php?c=Seafood
  /// Returns: List of meals in the specified category
  static const String filterByCategory = "$mealDbBaseUrl/filter.php";

  /// Filter by area/cuisine
  /// Example: /filter.php?a=Canadian
  /// Returns: List of meals from the specified area/cuisine
  static const String filterByArea = "$mealDbBaseUrl/filter.php";

  // ==================== IMAGE URLS ====================

  /// Base URL for meal images
  static const String mealImageBaseUrl =
      "https://www.themealdb.com/images/media/meals";

  /// Base URL for ingredient images
  static const String ingredientImageBaseUrl =
      "https://www.themealdb.com/images/ingredients";

  // ==================== HELPER METHODS ====================

  /// Get meal image URL with size
  /// Sizes: preview, small, medium, large
  static String getMealImageUrl(String imageName, {String size = 'medium'}) {
    // imageName format: llcbn01574260722.jpg
    final nameWithoutExt = imageName.split('.').first;
    return "$mealImageBaseUrl/$nameWithoutExt/$size";
  }

  /// Get ingredient image URL with size
  /// Sizes: (default), small, medium, large
  static String getIngredientImageUrl(
    String ingredientName, {
    String size = '',
  }) {
    final formattedName = ingredientName.toLowerCase().replaceAll(' ', '-');
    final sizePrefix = size.isNotEmpty ? '-$size' : '';
    return "$ingredientImageBaseUrl/$formattedName$sizePrefix.png";
  }

  // ==================== DYNAMIC ENDPOINTS ====================

  /// Search meal by name with query
  static String searchByName(String query) => "$searchMealByName?s=$query";

  /// Search meal by first letter
  static String searchByFirstLetter(String letter) =>
      "$searchMealByFirstLetter?f=$letter";

  /// Lookup meal by ID
  static String lookupById(String mealId) => "$lookupMealById?i=$mealId";

  /// Filter meals by ingredient
  static String filterByIngredientQuery(String ingredient) =>
      "$filterByIngredient?i=$ingredient";

  /// Filter meals by category
  static String filterByCategoryQuery(String category) =>
      "$filterByCategory?c=$category";

  /// Filter meals by area
  static String filterByAreaQuery(String area) => "$filterByArea?a=$area";


}
