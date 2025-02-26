import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:news/models/APiModelsServices.dart';
import 'package:news/service/ApiService.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Newsdetailsscreen extends StatefulWidget {
  final String imagePath;
  final String heroTag;
  final String NewsTitle;
  final String Newscontent;
  final String Newsdescription;
  final String NewsAuthor;
  final String NewsPublishDate;
  final String NewsUrl;

  const Newsdetailsscreen({
    super.key,
    required this.imagePath,
    required this.heroTag,
    required this.NewsTitle,
    required this.Newscontent,
    required this.Newsdescription,
    required this.NewsAuthor,
    required this.NewsPublishDate,
    required this.NewsUrl,
  });

  @override
  State<Newsdetailsscreen> createState() => _NewsdetailsscreenState();
}

class _NewsdetailsscreenState extends State<Newsdetailsscreen> {
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  List<Articles> newsApiViewItems = [];

  bool isLoading = true;
  // Loading state
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
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
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
              : Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                  ),
                  Hero(
                    tag: widget.heroTag,
                    child: ClipRRect(
                      child: Image.network(
                        widget.imagePath.isNotEmpty
                            ? widget.imagePath
                            : 'https://example.com/default-image.jpg',
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/placeholder.png',
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 16,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 270,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: screenHeight - 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.NewsTitle,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Author - ${widget.NewsAuthor}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Publish Date - ${widget.NewsPublishDate} ",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "News Content",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5),
                              ReadMoreText(
                                widget.Newscontent,
                                trimMode: TrimMode.Line,
                                trimLines: 3,
                                colorClickableText: Colors.blueAccent,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                                moreStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "News Description",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(height: 5),
                              ReadMoreText(
                                widget.Newsdescription,
                                trimMode: TrimMode.Line,
                                trimLines: 3,
                                colorClickableText: Colors.blueAccent,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                                moreStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "NEWS",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10),
                              GridView.builder(
                                itemCount:
                                    newsApiViewItems.isNotEmpty
                                        ? newsApiViewItems.length
                                        : 0, // ✅ Null check
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: Get.width * 0.03,
                                      crossAxisSpacing: Get.width * 0.02,
                                    ),
                                itemBuilder: (context, index) {
                                  if (index >= newsApiViewItems.length) {
                                    return SizedBox(); // ✅ Agar list empty ya out of range ho to blank return karo
                                  }

                                  final NewsItem = newsApiViewItems[index];

                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        () => Newsdetailsscreen(
                                          imagePath: NewsItem.urlToImage ?? "",
                                          heroTag:
                                              'newsHero${DateTime.now().millisecondsSinceEpoch}', // ✅ Unique Hero Tag
                                          NewsTitle:
                                              NewsItem.title ?? "No Title",
                                          Newscontent:
                                              NewsItem.content ?? "No Content",
                                          Newsdescription:
                                              NewsItem.description ??
                                              "No description",
                                          NewsAuthor:
                                              NewsItem.author ?? "No Author",
                                          NewsPublishDate:
                                              NewsItem.publishedAt ??
                                              "No Publish Date",
                                          NewsUrl: NewsItem.url ?? "No Url",
                                        ),
                                      );
                                    },
                                    child: AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      child: Container(
                                        key: ValueKey<int>(index),
                                        width: Get.width * 0.6,
                                        height: Get.height * 10.6,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 5,
                                              spreadRadius: 2,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Hero(
                                              tag:
                                                  'newsHero${index}_${DateTime.now().millisecondsSinceEpoch}', // ✅ Unique Hero Tag
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child:
                                                    NewsItem.urlToImage !=
                                                                null &&
                                                            NewsItem
                                                                .urlToImage!
                                                                .isNotEmpty
                                                        ? Image.network(
                                                          NewsItem.urlToImage!,
                                                          width:
                                                              Get.width * 0.5,
                                                          height:
                                                              Get.width * 0.25,
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (
                                                            context,
                                                            error,
                                                            stackTrace,
                                                          ) {
                                                            return Image.asset(
                                                              'assets/no_image.png',
                                                              width:
                                                                  Get.width *
                                                                  0.5,
                                                              height:
                                                                  Get.width *
                                                                  0.25,
                                                              fit: BoxFit.cover,
                                                            );
                                                          },
                                                        )
                                                        : Image.asset(
                                                          'assets/no_image.png',
                                                          width:
                                                              Get.width * 0.5,
                                                          height:
                                                              Get.width * 0.25,
                                                          fit: BoxFit.cover,
                                                        ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              NewsItem.title ?? "No Author",
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 5),
                                            // Text(NewsItem.author??'No Author')
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
