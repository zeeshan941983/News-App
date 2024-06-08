import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/model/catergories_model.dart';
import 'package:news_app/repository/news_repository.dart';
import 'package:news_app/view/Category/Cat_Details_Screen.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  String currentCategory = 'general';
  List<String> names = ['business', 'general', 'technology', 'sports'];
  final NewsRepository category = NewsRepository();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: names.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      currentCategory = names[index];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      names[index],
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    )),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<CategoriesNewsModel>(
              future: category.fetchCategoriesApi(currentCategory),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: spinkit,
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.articles?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      var article = snapshot.data!.articles![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CatDetailsScreen(data: article)));
                        },
                        child: Container(
                          height: height * 0.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[200]),
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                child: article.urlToImage != null
                                    ? CachedNetworkImage(
                                        imageUrl: article.urlToImage,
                                        height: height * 0.22,
                                        fit: BoxFit.fill,
                                        filterQuality: FilterQuality.high,
                                      )
                                    : Center(
                                        child: Image.asset(
                                        'assets/ntfound.png',
                                        fit: BoxFit.fill,
                                        height: height * 0.2,
                                      )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  article.title,
                                  style: GoogleFonts.raleway(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
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
          ),
        ],
      ),
    );
  }
}

const spinkit = SpinKitCircle(
  color: Colors.blue,
  size: 50,
);
