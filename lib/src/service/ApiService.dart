// news_api_service.dart

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:news/src/service/models/APiModelsServices.dart';

class NewsApiService {
  // Yeh function API se news fetch karega
  Future<List<Articles>> fetchNewsItems() async {
    try {
      //---------------->HTTP GET request bhej rahe hain news API par
      final response = await http.get(
        Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=77c3a262b2f544c090bb964aac3ff5a8",
        ),
      );

      //------------> Agar response ka status 200 hai to data process karein
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body); // JSON data decode kar rahe hain
        
        //-----------> Articles list bana rahe hain, sirf valid articles add honge (jisme title aur image ho)
        return (responseData['articles'] as List?)
                ?.map((value) => Articles.fromJson(value)) // JSON se Article object bana rahe hain
                .where((article) => article.title != null && article.urlToImage != null) // Null values hata rahe hain
                .toList() ?? 
            [];
      }
    } catch (e) {
      // Agar koi error aata hai to log me print karenge
      log("Error fetching data: $e");
    }

    // Agar error ho ya data na mile to empty list return karenge
    return [];
  }
}
