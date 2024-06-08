import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/catergories_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CatDetailsScreen extends StatefulWidget {
  dynamic data = [];
  CatDetailsScreen({super.key, required this.data});

  @override
  State<CatDetailsScreen> createState() => _CatDetailsScreenState();
}

class _CatDetailsScreenState extends State<CatDetailsScreen> {
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    var info = widget.data;
    DateTime date = DateTime.parse(info.publishedAt);
    DateFormat formate = DateFormat("dd/MMM/yyyy");
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // ClipPath(
              //   clipper: ContainerClipper(),
              //   child: Container(
              //     height: 200,
              //     width: 200,
              //     color: Colors.amber,
              //   ),
              // ),
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: CachedNetworkImage(imageUrl: info.urlToImage)),
              Text(
                info.title.toString(),
                style: GoogleFonts.raleway(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                formate.format(date),
                style: GoogleFonts.raleway(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Content :\n${info.content.toString()}",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                "Description : \n${info.description.toString()}",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  _launchUrl(info.url.toString());
                },
                child: Text(
                  "Link : \n${info.url.toString()}",
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ContainerClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, 200);
//     path.lineTo(200, 200);
//     path.quadraticBezierTo(0, 0, 220, 0);

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
