import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/models/service/ApiService.dart';
import 'package:news/models/APiModelsServices.dart';

class SearchController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final NewsApiService _newsApiService = NewsApiService();
  var allNews = <Articles>[].obs;
  var filteredNews = <Articles>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllNews();
  }

  Future<void> fetchAllNews() async {
    var news = await _newsApiService.fetchNewsItems();
    allNews.assignAll(news);
    filteredNews.assignAll(news);
    isLoading.value = false;
  }

  void searchNews(String query) {
    if (query.isEmpty) {
      filteredNews.assignAll(allNews);
      return;
    }

    filteredNews.assignAll(
      allNews.where(
        (article) => article.title!.toLowerCase().contains(query.toLowerCase()),
      ),
    );
  }
}
