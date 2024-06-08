import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/headlines_model.dart';

import 'package:news_app/veiw_model/news_veiw_model.dart';
import 'package:news_app/view/Category/categories.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final formate = DateFormat('MMMM,dd,yyyy');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "News",
              style: GoogleFonts.poppins(
                  fontSize: 25, fontWeight: FontWeight.w700),
            ),
            leading: IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Categories())),
                icon: Image.asset(
                  "assets/cattt.png",
                  height: 500,
                  width: 400,
                )),
            actions: [
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: width / 2,
                    height: height * 0.1,
                    child: DropdownButtonFormField<String>(
                      dropdownColor: Colors.amber.shade200,
                      decoration: InputDecoration(
                          fillColor: Colors.amber.shade200,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amber.shade200),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amber.shade200),
                              borderRadius: BorderRadius.circular(20)),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amber.shade200),
                              borderRadius: BorderRadius.circular(20))),
                      borderRadius: BorderRadius.circular(20),
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                      items: const [
                        DropdownMenuItem<String>(
                          value: 'abc-news',
                          child: Text("ABC"),
                        ),
                        DropdownMenuItem<String>(
                          value: 'ary-news',
                          child: Text("Ary News"),
                        ),
                        DropdownMenuItem<String>(
                          value: 'al-jazeera-english',
                          child: Text("Al Jazeera"),
                        ),
                        DropdownMenuItem<String>(
                          value: 'aftenposten',
                          child: Text("AftenPosten"),
                        ),
                        DropdownMenuItem<String>(
                          value: 'ansa',
                          child: Text("Ansa"),
                        ),
                        DropdownMenuItem<String>(
                          value: 'bbc-news',
                          child: Text("BBC"),
                        ),
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          current = value!;
                        });
                      },
                      hint: Text(current),
                    ),
                  ),
                ),
              ),
            ]),
        body: Column(children: [
          SizedBox(
            height: height * 0.02,
          ),
          SizedBox(
            height: height * 0.55,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewheadlineApi(current.toString()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Colors.blue,
                    ),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      var image =
                          snapshot.data!.articles[index].urlToImage.toString();
                      var title =
                          snapshot.data!.articles[index].title.toString();
                      // var description =
                      DateTime date = DateTime.parse(snapshot
                          .data!.articles[index].publishedAt
                          .toString());

                      var source = snapshot.data!.articles[index].source.name;
                      //     snapshot.data!.articles[index].description.toString();
                      // var link = snapshot.data!.articles[index].url.toString();
                      return SizedBox(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.02),
                              height: height * .6,
                              width: width * .9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: image,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    child: spinkit,
                                  ),
                                  errorListener: (value) => const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              child: Card(
                                elevation: 5,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Container(
                                  height: height * 0.22,
                                  padding: const EdgeInsets.all(12),
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width * 0.7,
                                        child: Text(
                                          title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: width * 0.7,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              source.toString(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              formate.format(date).toString(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                            // Text(title),
                            // Text(description),
                            // TextButton(
                            //     onPressed: () {
                            //       _launchUrl(link);
                            //     },
                            //     child: Text(link))
                          ],
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
        ]),
      ),
    );
  }
}

const spinkit = SpinKitCircle(
  color: Colors.blue,
  size: 50,
);
