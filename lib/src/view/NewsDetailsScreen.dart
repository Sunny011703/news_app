import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class Newsdetailsscreen extends StatelessWidget {
  final String imagePath; // News image ka URL
  final String heroTag; // Hero animation ke liye unique tag
  final String NewsTitle; // News ka title
  final String Newscontent; // News ka content
  final String Newsdescription; // News ka description
  final String NewsAuthor; // News ka author
  final String NewsPublishDate; // Publish date
  final String NewsUrl; // Original news article ka URL

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

  // Yeh function URL ko external browser me open karega
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url'; // Agar URL nahi khula to error show karega
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight =
        MediaQuery.of(context).size.height; // Screen height nikalna

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white, // Pure background white rakhna
          ),
          // Hero animation ke sath News image
          Hero(
            tag: heroTag,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.network(
                imagePath.isNotEmpty
                    ? imagePath
                    : 'https://example.com/default-image.jpg', // Agar imagePath empty ho to default image
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/placeholder.png', // Agar image load na ho to placeholder image
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          // Back button
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              onPressed:
                  () => Navigator.pop(context), // Screen close karne ke liye
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            ),
          ),
          // News content ka white background container
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height:
                  screenHeight - 250, // Screen ke bache hue part me fit hoga
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // News Title
                    Text(
                      NewsTitle,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Author & "Click Here" button for full news
                    Text(
                      "Author - ${NewsAuthor}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Publish Date
                    Text(
                      "Publish Date - ${NewsPublishDate} ",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    // News Content Heading
                    Text(
                      "News Content",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    // News content with "Read More"
                    ReadMoreText(
                      Newscontent,
                      trimMode: TrimMode.Line,
                      trimLines: 3,
                      colorClickableText: Colors.blueAccent,
                      trimCollapsedText: 'Show more', // Jab content chhota ho
                      trimExpandedText: 'Show less', // Jab content bada ho
                      moreStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // News Description Heading
                    Text(
                      "News Description",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 5),
                    // News description with "Read More"
                    ReadMoreText(
                      Newsdescription,
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
