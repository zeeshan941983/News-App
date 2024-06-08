import 'package:news_app/model/catergories_model.dart';
import 'package:news_app/model/headlines_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsVeiwModel {
  final _repo = NewsRepository();
  Future<NewsChannelsHeadlinesModel> fetchNewheadlineApi(String name) async {
    final response = _repo.fetchNewsChannelHeadlinesApi(name);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesApi(String category) async {
    final response = _repo.fetchCategoriesApi(category);
    return response;
  }
}
