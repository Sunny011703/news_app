import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/View/home/searchScreen.dart';
import 'package:shimmer/shimmer.dart';

class ViewallScreen extends StatefulWidget {
  const ViewallScreen({super.key});

  @override
  State<ViewallScreen> createState() => _ViewallScreenState();
}

class _ViewallScreenState extends State<ViewallScreen> {
  bool isLoading = true; // Loading state

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
                duration: const Duration(milliseconds: 400), // FIXED
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Get.width * 0.0,
                mainAxisSpacing: Get.width * 0.0,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: Container(
                      key: ValueKey<int>(index),
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: Offset(0, 3),
                          )
                        ]
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
