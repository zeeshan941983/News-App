import 'package:news_app/model/headlines_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsVeiwModel {
  final _repo = NewsRepository();
  Future<NewsChannelsHepdlinseModel> fetchNewheadlineApi() async {
    final response = _repo.fetchNewChannelHealinesApi();
    return response;
  }
}
