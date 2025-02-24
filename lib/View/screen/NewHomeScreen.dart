import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/models/service/ApiService.dart';
import 'package:news/models/APiModelsServices.dart';
import 'package:news/View/screen/NewsDetailsScreen.dart';
import 'package:news/View/screen/searchScreen.dart';
import 'package:news/View/screen/widget/bottonViewAll.dart';
import 'package:news/View/screen/widget/drawer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:auto_animated/auto_animated.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  int _current = 0;
  List<Articles> newsApiDataItems = [];
  bool isLoading = true;
  final NewsApiService _newsApiService = NewsApiService();

  final List<String> carouselSliderImages = [
    "assets/SliderImages/slider1.avif",
    "assets/SliderImages/slider2.avif",
    "assets/SliderImages/slider3.avif",
  ];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    newsApiDataItems = await _newsApiService.fetchNewsItems();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Home",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => Searchscreen(),
                transition: Transition.rightToLeftWithFade,
              );
            },
            icon: Icon(Icons.search, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),
      drawer: Drawer(child: DRAWERWIDGET()),
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
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    ButtomViewAll(title: 'Breaking News', onPressed: () {}),
                    const SizedBox(height: 10),
                    CarouselSlider.builder(
                      itemCount: carouselSliderImages.length,
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      itemBuilder: (context, index, realIdx) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            carouselSliderImages[index],
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * 0.9,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    ButtomViewAll(title: "Recommendation", onPressed: () {}),
                    NewsItemList(newsApiDataItems: newsApiDataItems),
                  ],
                ),
              ),
            ),
    );
  }
}

class NewsItemList extends StatelessWidget {
  const NewsItemList({super.key, required this.newsApiDataItems});

  final List<Articles> newsApiDataItems;

  @override
  Widget build(BuildContext context) {
    return LiveList(
      itemCount: newsApiDataItems.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index, animation) {
        final NewsItem = newsApiDataItems[index];

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, -0.1),
              end: Offset.zero,
            ).animate(animation),
            child: GestureDetector(
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
                  transition: Transition.rightToLeftWithFade,
                );
              },
              child: Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'newsImage$index',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        NewsItem.urlToImage ?? "null",
                        width: 180,
                        height: 140,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          NewsItem.title ?? "No Title",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          NewsItem.author ?? "Unknown",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          NewsItem.publishedAt ?? "No Date",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ),
          ),
        );
      },
    );
  }
}



// class NewsItemList extends StatelessWidget {
//   const NewsItemList({super.key, required this.newsApiDataItems});

//   final List<Articles> newsApiDataItems;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: newsApiDataItems.length,
//       shrinkWrap: true,
//       physics: ClampingScrollPhysics(),
//       itemBuilder: (context, index) {
//         final NewsItem = newsApiDataItems[index];

//         return Slidable(
//           key: ValueKey(index),
//           endActionPane: ActionPane(
//             motion: const DrawerMotion(),
//             children: [
//               SlidableAction(
//                 onPressed: (context) {
//                   newsApiDataItems.removeAt(index);
//                 },
//                 backgroundColor: Colors.red,
//                 foregroundColor: Colors.white,
//                 icon: Icons.delete,
//                 label: 'Delete',
//               ),
//             ],
//           ),
//           child: GestureDetector(
//             onTap: () {
//               Get.to(
//                 () => Newsdetailsscreen(
//                   imagePath: NewsItem.urlToImage ?? "",
//                   heroTag: 'newsImage$index',
//                   NewsTitle: NewsItem.title ?? "No Title",
//                   Newscontent: NewsItem.content ?? "No Content",
//                   Newsdescription: NewsItem.description ?? "No description",
//                   NewsAuthor: NewsItem.author ?? "No Author",
//                   NewsPublishDate: NewsItem.publishedAt ?? "No Publish Date",
//                   NewsUrl: NewsItem.url ?? "No Url",
//                 ),
//                 transition: Transition.rightToLeftWithFade,
//               );
//             },
           
//           ),
//         );
//       },
//     );
//   }
// }
