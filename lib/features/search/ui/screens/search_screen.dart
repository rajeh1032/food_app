import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:food_app/features/search/ui/Widgets/last_viewed.dart';
import 'package:food_app/features/search/ui/Widgets/search_history.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  final List lastViewed = [];
  final List searchHistory = [];

  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List meals = [];
  bool isLoading = false;
  String currentQuery = "";
  Timer? _debounce;

  bool showAllHistory = false;
  bool showAllViewed = false;

  final Random _random = Random();

  String randomRate() {
    double rate = (1 + _random.nextDouble() * 4);
    return "(${rate.toStringAsFixed(1)})";
  }

  void onSearchChanged(String query) {
    currentQuery = query;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchMeals(query);
    });
    setState(() {});
  }

  Future<void> searchMeals(String query) async {
    if (query.isEmpty) {
      setState(() { meals = []; });
      return;
    }
    setState(() { isLoading = true; });

    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$query'),
      );


      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          meals = data['meals'] ?? [];
          isLoading = false;
        });
      } else {
        setState(() { isLoading = false; });
      }
    } catch (e) {
      setState(() { isLoading = false; });
    }
  }

  Widget buildSectionHeader(String title, bool showAll, VoidCallback toggleShowAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppStyles.titleLarge.copyWith(color: AppColors.black, fontSize: 18)),
        TextButton(
          onPressed: toggleShowAll,
          child: Text(
            showAll ? "Show Less" : "See All",
            style: TextStyle(color: AppColors.difficultyMedium, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget buildHorizontalList(List data, bool showAll) {
    if (data.isEmpty) return const SizedBox.shrink();
    int itemCount = showAll ? data.length : (data.length > 3 ? 3 : data.length);

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final meal = data[index];
          return LastViewed(
            image: meal['strMealThumb'] ?? '',
            title: meal['strMeal'] ?? '',
            rate: meal['rate'] ?? "(3.5)",
          );
        },
      ),
    );
  }

  Widget buildVerticalList(List data, bool showAll) {
    if (data.isEmpty) return const SizedBox.shrink();
    int itemCount = showAll ? data.length : (data.length > 3 ? 3 : data.length);

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final meal = data[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SearchHistory(
            title: meal['strMeal'] ?? '',
            image: meal['strMealThumb'] ?? '',
            rate: meal['rate'] ?? "(3.5)",
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                padding: const EdgeInsets.only(top: 60),
                child: TextFormField(
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    hintText: "Type ingredients...",
                    hintStyle: AppStyles.labelMedium.copyWith(fontSize: 15),
                    prefixIcon: Icon(Icons.search, color: AppColors.gray500),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              buildSectionHeader("Search History", showAllHistory, () {
                setState(() { showAllHistory = !showAllHistory; });
              }),
              buildVerticalList(widget.searchHistory, showAllHistory),

              const SizedBox(height: 10),

              buildSectionHeader("Last Viewed", showAllViewed, () {
                setState(() { showAllViewed = !showAllViewed; });
              }),
              buildHorizontalList(widget.lastViewed, showAllViewed),

              const SizedBox(height: 25),

              Text("Based on your search",
                  style: AppStyles.titleLarge.copyWith(color: AppColors.black)),
              const SizedBox(height: 15),

              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : meals.isEmpty
                  ? const Center(child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("No results found"),
              ))
                  : GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  mainAxisExtent: 210,
                ),
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  final meal = meals[index];
                  final mealWithRate = {
                    ...Map<String, dynamic>.from(meal),
                    'rate': randomRate(),
                  };

                  return GestureDetector(
                    onTap: () {
                      setState(() {

                        widget.lastViewed.removeWhere((m) => m['idMeal'] == mealWithRate['idMeal']);
                        widget.lastViewed.insert(0, mealWithRate);

                        widget.searchHistory.removeWhere((m) => m['idMeal'] == mealWithRate['idMeal']);
                        widget.searchHistory.insert(0, mealWithRate);

                        if (widget.searchHistory.length > 10) widget.searchHistory.removeLast();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.network(
                              mealWithRate['strMealThumb'] ?? '',
                              height: 125,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mealWithRate['strMeal'] ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyles.titleMedium.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      mealWithRate['rate'],
                                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}