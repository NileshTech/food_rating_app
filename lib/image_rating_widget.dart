import 'package:flutter/material.dart';
import 'package:food_rating/rating_page.dart';

class ImageRatingWidget extends StatefulWidget {
  final String? secretFromFlickrAPI;
  final String? idFromFlickrAPI;
  final String? serverFromFlickrAPI;
  final String? title;

  const ImageRatingWidget(
      {Key? key,
      this.secretFromFlickrAPI,
      this.idFromFlickrAPI,
      this.serverFromFlickrAPI,
      this.title})
      : super(key: key);

  @override
  _ImageRatingWidgetState createState() => _ImageRatingWidgetState();
}

class _ImageRatingWidgetState extends State<ImageRatingWidget> {
  double value = 0.5;
  double rating = 0.5;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20.0)),
          child: Center(
            child: Image.network(
                'https://live.staticflickr.com/${widget.serverFromFlickrAPI}/${widget.idFromFlickrAPI}_${widget.secretFromFlickrAPI}.jpg'),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RatingPage(
                    secretFromFlickrAPI: widget.secretFromFlickrAPI,
                    idFromFlickrAPI: widget.idFromFlickrAPI,
                    serverFromFlickrAPI: widget.serverFromFlickrAPI,
                    title: widget.title,
                  )),
        );
      },
    );
  }
}
