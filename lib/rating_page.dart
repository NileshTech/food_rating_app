import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class RatingPage extends StatefulWidget {
  final String? secretFromFlickrAPI;
  final String? idFromFlickrAPI;
  final String? serverFromFlickrAPI;
  final String? title;
  const RatingPage(
      {Key? key,
      this.secretFromFlickrAPI,
      this.idFromFlickrAPI,
      this.serverFromFlickrAPI,
      this.title})
      : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double value = 0.5;
  double rating = 0.5;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Title of the Image
              Text(
                "${widget.title}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              //Image
              Image.network(
                  'https://live.staticflickr.com/${widget.serverFromFlickrAPI}/${widget.idFromFlickrAPI}_${widget.secretFromFlickrAPI}.jpg'),

              //Rating form
              Container(
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
              Container(
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Why you feel this image deservs this rating?',
                    labelText: 'Reason for rating',
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
              RatingStars(
                value: value,
                onValueChanged: (v) {
                  setState(() {
                    value = v;
                  });
                },
                starBuilder: (index, color) => Icon(
                  Icons.star_border,
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
              MaterialButton(
                  color: Colors.indigo,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Submit", style: TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ),
    );
  }
}
