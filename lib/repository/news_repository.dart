import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/headlines_model.dart';

class NewsRepository {
  Future<NewsChannelsHepdlinseModel> fetchNewChannelHealinesApi() async {
    String key = "ec94ae7f19934a4c87fd77965654949f";
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=ec94ae7f19934a4c87fd77965654949f ";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return NewsChannelsHepdlinseModel.fromJson(body);
    }
    throw Exception("Error");
  }
}
