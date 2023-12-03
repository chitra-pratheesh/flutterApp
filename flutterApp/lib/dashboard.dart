import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<ImageProvider> _preloadedImages = [];
  // a list of images' URLs
  List data = [];
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    final response = await http
        .get(Uri.parse("https://picsum.photos/v2/list?page=1&limit=100"));
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 750,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color.fromRGBO(233, 65, 82, 1),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10, color: Colors.black, offset: Offset(1, 5))
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(20)),
                    
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  SizedBox(
                      height: 60,
                    ),
                    Text("Dashboard",
                        style: GoogleFonts.pacifico(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white,
                        )),
                        Container(
                          height: 8,
                          color: Color.fromRGBO(255, 255, 255, 0.4),
                          margin: const EdgeInsets.all(5.0),
                        ),
                  CarouselSlider.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index, realIndex) {
                      // Check if the image is already preloaded, if not, preload it.
                      if (_preloadedImages.length <= index) {
                        _precacheImage(data[index]["download_url"]);
                      }

                      return CachedNetworkImage(
                        imageUrl: data[index]["download_url"],
                        imageBuilder: (context, imageProvider) {
                          // If the image is preloaded, use it directly from the cache.
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.red,
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.red,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 550.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _precacheImage(String imageUrl) {
    final imageProvider = CachedNetworkImageProvider(imageUrl);
    precacheImage(imageProvider, context);
    _preloadedImages.add(imageProvider);
  }
}
