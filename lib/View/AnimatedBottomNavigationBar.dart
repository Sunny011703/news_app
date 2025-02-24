import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/View/Personalization/UserProfile.dart';
import 'package:news/ViewModels/AnimatedBottomNavController.dart';
import 'package:news/View/view/LIveVideo.dart';
import 'package:news/View/view/NewHomeScreen.dart';

class AnimatedBottomNavigationBar extends StatelessWidget {
  AnimatedBottomNavigationBar({super.key});
  final BottomNavController controller = Get.put(BottomNavController()); //---------->Inject GetX Controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.selectedIndex.value = index; //----------------->Update index
        },
        children: const [
          NewHomeScreen(),
          LivevideoScreen(),
          UserprofileScreen(),
        ],
      ),

      bottomNavigationBar: Obx(() => CurvedNavigationBar(
            index: controller.selectedIndex.value, //--------------> Only updating this value
            height: 50,
            backgroundColor: Colors.white,
            color: Colors.blueAccent,
            animationDuration: Duration(milliseconds: 300),
            items: const [
              Icon(Icons.home, size: 30, color: Colors.white),
              Icon(Icons.live_tv, size: 30, color: Colors.white),
              Icon(Icons.person, size: 30, color: Colors.white),
            ],
            onTap: (index) {
              controller.changePage(index);
            },
          )),
    );
  }
}
