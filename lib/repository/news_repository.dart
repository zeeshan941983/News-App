import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/catergories_model.dart';
import 'package:news_app/model/headlines_model.dart';

class NewsRepository {
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(
      String newsChannel) async {
    String newsUrl =
        'https://newsapi.org/v2/top-headlines?sources=${newsChannel}&apiKey=ec94ae7f19934a4c87fd77965654949f';

    final response = await http.get(Uri.parse(newsUrl));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }

  Future<CategoriesNewsModel> fetchCategoriesApi(String category) async {
    String newsUrl =
        'https://newsapi.org/v2/everything?q=$category&apiKey=ec94ae7f19934a4c87fd77965654949f';

    final response = await http.get(Uri.parse(newsUrl));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }
}
