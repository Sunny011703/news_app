import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/View/home/NewsDetailsScreen.dart';
import 'package:news/View/home/searchScreen.dart';
import 'package:news/models/APiModelsServices.dart';
import 'package:news/service/ApiService.dart';
import 'package:shimmer/shimmer.dart';

class ViewallScreen extends StatefulWidget {
  const ViewallScreen({super.key});

  @override
  State<ViewallScreen> createState() => _ViewallScreenState();
}

class _ViewallScreenState extends State<ViewallScreen> {
  List<Articles> newsApiViewItems = [];
  bool isLoading = true; // Loading state
  final NewsApiService _newsApiService = NewsApiService();

  @override
  void initState() {
    super.initState();
    fetchNews(); // ✅ API call ko initState() me add kiya
  }

  Future<void> fetchNews() async {
    newsApiViewItems = await _newsApiService.fetchNewsItems();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          "Recommendation",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => Searchscreen(),
                transition: Transition.rightToLeftWithFade,
                duration: const Duration(milliseconds: 400),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: isLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: Get.width * 0.2,
                          width: Get.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 10,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 100,
                                height: 10,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: ListView.builder(
                itemCount: newsApiViewItems.length,
                itemBuilder: (context, index) {
                  final NewsItem = newsApiViewItems[index];

                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => Newsdetailsscreen(
                          imagePath: NewsItem.urlToImage ?? "",
                          heroTag: 'newsImage$index',
                          NewsTitle: NewsItem.title ?? "No Title",
                          Newscontent: NewsItem.content ?? "No Content",
                          Newsdescription: NewsItem.description ?? "No description",
                          NewsAuthor: NewsItem.author ?? "No Author",
                          NewsPublishDate: NewsItem.publishedAt ?? "No Publish Date",
                          NewsUrl: NewsItem.url ?? "No Url",
                        ),
                      );
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        key: ValueKey<int>(index),
                        margin: const EdgeInsets.all(6),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 2,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Hero(
                              tag: 'newsImage$index',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: NewsItem.urlToImage != null && NewsItem.urlToImage!.isNotEmpty
                                    ? Image.network(
                                        NewsItem.urlToImage!,
                                        width: Get.width * 0.4,
                                        height: Get.width * 0.25,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/no_image.png',
                                            width: Get.width * 0.4,
                                            height: Get.width * 0.25,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      )
                                    : Image.asset(
                                        'assets/no_image.png',
                                        width: Get.width * 0.4,
                                        height: Get.width * 0.25,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    NewsItem.title ?? 'No Title',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    NewsItem.author ?? 'No Author',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    NewsItem.publishedAt ?? 'Null Published',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
