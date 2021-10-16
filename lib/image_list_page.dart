import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:food_rating/data.dart';
import 'package:food_rating/image_rating_widget.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import "dart:async";

class ImageListPage extends StatefulWidget {
  final int? indexForRating;
  final double? ratingFromUser;
  final bool? showRating;
  const ImageListPage(
      {Key? key,
      this.indexForRating,
      this.ratingFromUser,
      this.showRating = false})
      : super(key: key);

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
    double? rating = 0.5;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.indigo,
            title:
                Text("Food Rating App", style: TextStyle(color: Colors.white)),
          ),
          body: Center(
            child: data == null
                ? CircularProgressIndicator(color: Colors.indigo)
                : CarouselSlider.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int? itemIndex,
                        int pageViewIndex) {
                      int? index = itemIndex;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.lime.shade50,
                              border: Border.all(
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "${data![itemIndex!]["title"]}",
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: ImageRatingWidget(
                                  secretFromFlickrAPI: data![itemIndex]
                                      ["secret"],
                                  serverFromFlickrAPI: data![itemIndex]
                                      ["server"],
                                  idFromFlickrAPI: data![itemIndex]["id"],
                                  title: data![itemIndex]["title"],
                                  index: index,
                                ),
                              ),
                              indexOfCarousalImages.keys
                                      .contains(data![itemIndex]["title"])
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RatingStars(
                                        value: indexOfCarousalImages[
                                            (data![itemIndex]["title"])]!,
                                        starBuilder: (index, color) => Icon(
                                          Icons.star_rate,
                                          color: color,
                                        ),
                                        starCount: 5,
                                        starSize: 20,
                                        valueLabelColor:
                                            const Color(0xff9b9b9b),
                                        valueLabelRadius: 10,
                                        maxValue: 5,
                                        starSpacing: 3,
                                        maxValueVisibility: true,
                                        valueLabelVisibility: false,
                                        animationDuration:
                                            Duration(milliseconds: 1000),
                                        valueLabelPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 1, horizontal: 8),
                                        valueLabelMargin:
                                            const EdgeInsets.only(right: 8),
                                        starOffColor:
                                            Colors.indigo.withOpacity(0.5),
                                        starColor: Colors.indigo,
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RatingStars(
                                        value: rating,
                                        starBuilder: (index, color) => Icon(
                                          Icons.star_rate,
                                          color: color,
                                        ),
                                        starCount: 5,
                                        starSize: 20,
                                        valueLabelColor:
                                            const Color(0xff9b9b9b),
                                        valueLabelRadius: 10,
                                        maxValue: 5,
                                        starSpacing: 3,
                                        maxValueVisibility: true,
                                        valueLabelVisibility: false,
                                        animationDuration:
                                            Duration(milliseconds: 1000),
                                        valueLabelPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 1, horizontal: 8),
                                        valueLabelMargin:
                                            const EdgeInsets.only(right: 8),
                                        starOffColor:
                                            Colors.indigo.withOpacity(0.5),
                                        starColor: Colors.indigo,
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text("${(itemIndex + 1)} / 10"),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 400,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.6,
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
          )),
    );
  }
}
