import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/Tech_Model.dart';
import 'package:news_app/model/headlines_model.dart';

import 'package:news_app/veiw_model/news_veiw_model.dart';
import 'package:news_app/view/Category/Cat_Details_Screen.dart';
import 'package:news_app/view/Category/categories.dart';
import 'package:news_app/view/widgets/dropdown.dart';

enum Filterlist {
  bbcNews,
  aryNews,
  abcnews,
  aftenposten,
  aljazeeraenglish,
  ansa,
  bbcnews,
  cbcnews
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsVeiwModel newsViewModel = NewsVeiwModel();

  String current = 'ary-news';
  final format = DateFormat('MMMM,dd,yyyy');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "News",
          style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Categories())),
          icon: Image.asset(
            "assets/cattt.png",
            height: 50,
            width: 40,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Headlines",
                    style: GoogleFonts.prompt(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  HomeDropdown(
                    onchange: (value) {
                      setState(() {
                        current = value!;
                      });
                    },
                    current: current,
                  )
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewheadlineApi(current.toString()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Colors.blue,
                    ),
                  );
                } else if (snapshot.hasData) {
                  return SizedBox(
                    height: height * 0.26,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        var image = snapshot.data!.articles[index].urlToImage
                            .toString();
                        var title =
                            snapshot.data!.articles[index].title.toString();

                        DateTime date = DateTime.parse(snapshot
                            .data!.articles[index].publishedAt
                            .toString());

                        return Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.02),
                              height: height * .26,
                              width: width * .9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: image,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    child: spinkit,
                                  ),
                                  errorListener: (value) => Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: height * 0.12,
                              child: Container(
                                height: height * 0.13,
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.all(12),
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width * 0.7,
                                      child: Text(
                                        title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          format.format(date),
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("No data available"),
                  );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: height * 0.01,
                  top: height * 0.03,
                  bottom: height * 0.02),
              child: Text(
                "Recent News",
                style: GoogleFonts.prompt(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<TechModel>(
              future: newsViewModel.fetchTechApi(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Colors.blue,
                    ),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.articles.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = snapshot.data.articles[index];
                      DateTime date =
                          DateTime.parse(data.publishedAt.toString());
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CatDetailsScreen(data: data)));
                          },
                          child: SizedBox(
                            height: height * 0.2,
                            width: width,
                            child: Card(
                              color: Colors.black,
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: data.urlToImage,
                                    fit: BoxFit.cover,
                                    width: width * 0.4,
                                    height: height * 0.4,
                                    placeholder: (context, url) => Container(
                                      child: spinkit,
                                    ),
                                    errorListener: (value) => const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 2,
                                    child: ListTile(
                                      title: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                        data.title,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        format.format(date),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("No data available"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

const spinkit = SpinKitCircle(
  color: Colors.blue,
  size: 50,
);
