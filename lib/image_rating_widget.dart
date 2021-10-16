import 'package:flutter/material.dart';
import 'package:food_rating/rating_page.dart';

class ImageRatingWidget extends StatefulWidget {
  final String? secretFromFlickrAPI;
  final String? idFromFlickrAPI;
  final String? serverFromFlickrAPI;
  final String? title;

  final int? index;

  const ImageRatingWidget(
      {Key? key,
      this.secretFromFlickrAPI,
      this.idFromFlickrAPI,
      this.serverFromFlickrAPI,
      this.title,
      this.index})
      : super(key: key);

  @override
  _ImageRatingWidgetState createState() => _ImageRatingWidgetState();
}

class _ImageRatingWidgetState extends State<ImageRatingWidget> {
  double? value;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20,
      child: InkWell(
        child: Image.network(
            'https://live.staticflickr.com/${widget.serverFromFlickrAPI}/${widget.idFromFlickrAPI}_${widget.secretFromFlickrAPI}.jpg',
            fit: BoxFit.fill),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RatingPage(
                      secretFromFlickrAPI: widget.secretFromFlickrAPI,
                      idFromFlickrAPI: widget.idFromFlickrAPI,
                      serverFromFlickrAPI: widget.serverFromFlickrAPI,
                      title: widget.title,
                      index: widget.index,
                    )),
          );
        },
      ),
    );
  }
}
