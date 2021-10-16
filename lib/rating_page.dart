import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:food_rating/data.dart';
import 'image_list_page.dart';

class RatingPage extends StatefulWidget {
  final String? secretFromFlickrAPI;
  final String? idFromFlickrAPI;
  final String? serverFromFlickrAPI;
  final String? title;
  final int? index;

  const RatingPage(
      {Key? key,
      this.secretFromFlickrAPI,
      this.idFromFlickrAPI,
      this.serverFromFlickrAPI,
      this.title,
      this.index})
      : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double value = 0.5;
  double rating = 0.5;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo,
          title: Text("Food Rating App", style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Title of the Image
              SizedBox(
                height: screenSize.height * 0.08,
                child: Center(
                  child: Text(
                    "${widget.title}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              //Image
              SizedBox(
                height: screenSize.height * 0.4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                      'https://live.staticflickr.com/${widget.serverFromFlickrAPI}/${widget.idFromFlickrAPI}_${widget.secretFromFlickrAPI}.jpg'),
                ),
              ),

              //Rating form
              SizedBox(
                height: screenSize.height * 0.1,
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'What do people call you?',
                    labelText: 'Name',
                  ),
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? 'Do not use the @ char.'
                        : null;
                  },
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.1,
                child: Container(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.message),
                      hintText: 'Why you feel this image deservs this rating?',
                      labelText: 'Comments',
                    ),
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.1,
                child: RatingStars(
                  value: value,
                  onValueChanged: (v) {
                    setState(() {
                      value = v;
                    });
                  },
                  starBuilder: (index, color) => Icon(
                    Icons.star_rate,
                    color: color,
                  ),
                  starCount: 5,
                  starSize: 25,
                  valueLabelColor: const Color(0xff9b9b9b),
                  valueLabelTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0),
                  valueLabelRadius: 10,
                  maxValue: 5,
                  starSpacing: 3,
                  maxValueVisibility: true,
                  valueLabelVisibility: true,
                  animationDuration: Duration(milliseconds: 1000),
                  valueLabelPadding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  valueLabelMargin: const EdgeInsets.only(right: 8),
                  starOffColor: const Color(0xffe7e8ea),
                  starColor: Colors.indigo,
                ),
              ),
              MaterialButton(
                  color: Colors.indigo,
                  onPressed: () {
                    indexOfCarousalImages[widget.title] = value;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageListPage(
                                ratingFromUser: value,
                                indexForRating: widget.index,
                                showRating: true,
                              )),
                    );
                  },
                  child: Text("Submit", style: TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ),
    );
  }
}
