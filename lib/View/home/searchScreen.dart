import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/service/ApiService.dart';
import 'package:news/models/APiModelsServices.dart';
import 'package:news/View/home/NewsDetailsScreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_slidable/flutter_slidable.dart'; // ✅ Import flutter_slidable

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final TextEditingController _searchController = TextEditingController();
  final NewsApiService _newsApiService = NewsApiService();
  List<Articles> allNews = [];
  List<Articles> filteredNews = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllNews();
  }

  Future<void> fetchAllNews() async {
    allNews = await _newsApiService.fetchNewsItems();
    setState(() {
      filteredNews = allNews;
      isLoading = false;
    });
  }

  void _searchNews(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredNews = allNews;
      });
      return;
    }
    setState(() {
      filteredNews =
          allNews
              .where(
                (article) =>
                    article.title!.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey.shade200,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.shade100,
                ),
                child: TextFormField(
                  controller: _searchController,
                  onChanged: _searchNews,
                  decoration: InputDecoration(
                    hintText: "Search news...",
                    hintStyle: GoogleFonts.poppins(fontSize: 14),
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search, color: Colors.black54),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body:
          isLoading
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
                            height: 50,
                            width: 50,
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
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 15.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Discover",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "News from all around the world",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Expanded(
                      child:
                          filteredNews.isEmpty
                              ? Center(
                                child: Text(
                                  "No news found...",
                                  style: GoogleFonts.poppins(fontSize: 16),
                                ),
                              )
                              : ListView.builder(
                                itemCount: filteredNews.length,
                                itemBuilder: (context, index) {
                                  final newsItem = filteredNews[index];
                                  return Slidable(
                                    key: ValueKey(index),
                                    endActionPane: ActionPane(
                                      motion: const DrawerMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            setState(() {
                                              filteredNews.removeAt(index);
                                            });
                                          },
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        newsItem.title ?? "No Title",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                      ),
                                      subtitle: Text(
                                        newsItem.author ?? "Unknown",
                                      ),
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          newsItem.urlToImage ??
                                              "https://via.placeholder.com/150",
                                          width: 80,
                                          height: 60,
                                          fit: BoxFit.cover,
                                          errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {
                                            return Icon(
                                              Icons.broken_image,
                                              size: 50,
                                            );
                                          },
                                        ),
                                      ),
                                      onTap: () {
                                        Get.to(
                                          () => Newsdetailsscreen(
                                            imagePath:
                                                newsItem.urlToImage ?? "",
                                            heroTag: "news_$index",
                                            NewsTitle:
                                                newsItem.title ?? "No Title",
                                            Newscontent:
                                                newsItem.content ??
                                                "No Content",
                                            Newsdescription:
                                                newsItem.description ??
                                                "No Description",
                                            NewsAuthor:
                                                newsItem.author ?? "Unknown",
                                            NewsPublishDate:
                                                newsItem.publishedAt ??
                                                "No Date",
                                            NewsUrl: newsItem.url ?? "",
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                    ),
                  ],
                ),
              ),
    );
  }
}
