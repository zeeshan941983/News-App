import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/model/headlines_model.dart';
import 'package:news_app/repository/news_repository.dart';
import 'package:news_app/veiw_model/news_veiw_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    NewsVeiwModel newsVeiwModel = NewsVeiwModel();
    return Scaffold(
        body: ListView(
      children: [
        FutureBuilder<NewsChannelsHepdlinseModel>(
          future: newsVeiwModel.fetchNewheadlineApi(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitCircle(
                  color: Colors.blue,
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.articlesList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                        snapshot.data.articlesList['title'][index] ?? "hello");
                  },
                ),
              );
            }
          },
        ),
      ],
    ));
  }
}
