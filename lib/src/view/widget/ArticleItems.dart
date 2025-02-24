// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:news/src/service/ApiService.dart';
// import 'package:news/src/service/models/APiModelsServices.dart';
// import 'package:news/src/view/NewsDetailsScreen.dart';

// class ArticleItemsWidget extends StatefulWidget {
//   const ArticleItemsWidget({super.key});

//   @override
//   _ArticleItemsWidgetState createState() => _ArticleItemsWidgetState();
// }

// class _ArticleItemsWidgetState extends State<ArticleItemsWidget> {
//   List<Articles> newsApiDataItems = [];
//   bool isLoading = true;
//   final NewsApiService _newsApiService = NewsApiService();

//   @override
//   void initState() {
//     super.initState();
//     fetchNewsData();
//   }

//   Future<void> fetchNewsData() async {
//     try {
//       final List<Articles>? fetchedNews = await _newsApiService.fetchNews();
//       if (fetchedNews != null) {
//         setState(() {
//           newsApiDataItems = fetchedNews;
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print("Error fetching news: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? Center(child: CircularProgressIndicator())
//         : ListView.builder(
//             itemCount: newsApiDataItems.length,
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               final article = newsApiDataItems[index];
//               return GestureDetector(
//                 onTap: () {
//                   Get.to(
//                     () => Newsdetailsscreen(
//                       imagePath: article.urlToImage ?? "assets/SliderImages/images.jpg",
//                       heroTag: "news_$index",
//                       NewsTitle: article.title ?? "No Title",
//                       Newscontent: article.content ?? "No Content",
//                       Newsdescription: article.description ?? "No Description",
//                       NewsAuthor: article.author ?? "Unknown",
//                       NewsPublishDate: article.publishedAt ?? "No Date",
//                       NewsUrl: article.url ?? "",
//                     ),
//                     transition: Transition.rightToLeftWithFade,
//                   );
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(width: 0.5, color: Colors.black12),
//                   ),
//                   margin: EdgeInsets.all(5),
//                   padding: EdgeInsets.all(5),
//                   child: Row(
//                     children: [
//                       Hero(
//                         tag: "news_$index",
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.network(
//                             article.urlToImage ?? "assets/SliderImages/images.jpg",
//                             width: 120,
//                             height: 120,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Image.asset(
//                                 "assets/SliderImages/images.jpg",
//                                 width: 120,
//                                 height: 120,
//                                 fit: BoxFit.cover,
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               article.title ?? "No Title Available",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             SizedBox(height: 8),
//                             Row(
//                               children: [
//                                 Text(
//                                   article.author ?? "Unknown Author",
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 Text(
//                                   article.publishedAt?.split("T")[0] ?? "No Date",
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.grey[700],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//   }
// }
