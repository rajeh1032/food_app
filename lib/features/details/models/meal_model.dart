class Meal {
  final String id;
  final String name;
  final String? alternateName;
  final String category;
  final String area;
  final String instructions;
  final String thumb;
  final String? tags;
  final String? youtube;
  final List<String> ingredients;
  final List<String> measures;

  Meal({
    required this.id,
    required this.name,
    this.alternateName,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumb,
    this.tags,
    this.youtube,
    required this.ingredients,
    required this.measures,
  });

  static String _requiredString(
    Map<String, dynamic> json,
    String key, {
    String fallback = '',
  }) {
    final value = json[key];
    if (value == null) return fallback;

    final parsed = value.toString().trim();
    return parsed.isEmpty ? fallback : parsed;
  }

  static String? _optionalString(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return null;

    final parsed = value.toString().trim();
    return parsed.isEmpty ? null : parsed;
  }

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      final parsedIngredient = ingredient?.toString().trim();
      if (parsedIngredient != null && parsedIngredient.isNotEmpty) {
        ingredients.add(parsedIngredient);
        measures.add(measure?.toString().trim() ?? '');
      }
    }

    return Meal(
      id: _requiredString(json, 'idMeal'),
      name: _requiredString(json, 'strMeal', fallback: 'Unknown meal'),
      alternateName: _optionalString(json, 'strMealAlternate'),
      category: _requiredString(json, 'strCategory'),
      area: _requiredString(json, 'strArea'),
      instructions: _requiredString(json, 'strInstructions'),
      thumb: _requiredString(json, 'strMealThumb'),
      tags: _optionalString(json, 'strTags'),
      youtube: _optionalString(json, 'strYoutube'),
      ingredients: ingredients,
      measures: measures,
    );
  }
}
