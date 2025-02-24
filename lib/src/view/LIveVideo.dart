import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chewie/chewie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class LivevideoScreen extends StatefulWidget {
  const LivevideoScreen({super.key});

  @override
  State<LivevideoScreen> createState() => _LivevideoScreenState();
}

class _LivevideoScreenState extends State<LivevideoScreen> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeVideo();
  }

  Future<void> initializeVideo() async {
    try {
      videoPlayerController = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=4ZROAsqu5Xk',
      );

      await videoPlayerController!.initialize();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
        looping: true,
      );
    } catch (e) {
      debugPrint('Error initializing video: $e');
    }

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              "Live ",
              style: GoogleFonts.aBeeZee(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
            Text(
              "NEWS ",
              style: GoogleFonts.aBeeZee(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.white,
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
              )
            : (chewieController != null
                ? Chewie(controller: chewieController!)
                : const Text("Error loading video")),
      ),
    );
  }
}
