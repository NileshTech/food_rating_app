import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import 'package:food_rating/carousal_item_details.dart';
import 'package:food_rating/data.dart';
import 'package:food_rating/image_rating_widget.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import "dart:async";

class ImageListPage extends StatefulWidget {
  const ImageListPage({Key? key}) : super(key: key);

  @override
  _ImageListPageState createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {
  List<dynamic>? data; //Declaring a List to store the decoded List of maps

  Future<void> fetchData() async {
    var url = Uri.parse(
        'https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=${API_KEY}&tags=pizza&format=json&nojsoncallback=1');
    final result = await http.Client().get(url);
    if (json.decode(result.body) != null) {
      setState(() {
        data = (json.decode(result.body))["photos"]["photo"];
      });
    }
  }

  void initState() {
    super.initState();
    fetchData(); //Function call in initState to fetch data as soon as application is started.
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: data == null
            ? CircularProgressIndicator(color: Colors.indigo)
            : Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Container(
                  child: CarouselSlider.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: ImageRatingWidget(
                                secretFromFlickrAPI: data![itemIndex]["secret"],
                                serverFromFlickrAPI: data![itemIndex]["server"],
                                idFromFlickrAPI: data![itemIndex]["id"],
                                title: data![itemIndex]["title"]),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          right: 20,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                                color: Colors.amber[50],
                                border: Border.all(
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${data![itemIndex]["title"]}",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    options: CarouselOptions(
                      height: 400,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ),
      )),
    );
  }
}
