
import 'package:flutter/material.dart';

import 'package:educastle/stub_data.dart';

class Review extends StatefulWidget {

  @override
  ReviewState createState() => ReviewState();

}

class ReviewState extends State<Review> {

  @override
  void initState() {
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('평점 / 리뷰보기'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
          children: <Widget>[
            _StarBar(
              rating: 3,
            ),
            const _Reviews(),
            
          ]
        ),
      ),
    );
  }
}

class _StarBar extends StatelessWidget {
  const _StarBar({
    @required this.rating,
    Key key,
  })  : assert(rating != null && rating >= 0 && rating <= maxStars),
        super(key: key);

  static const int maxStars = 5;
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxStars, (index) {
        return IconButton(
          icon: const Icon(Icons.star),
          iconSize: 40.0,
          color: rating > index ? Colors.amber : Colors.grey[400],
          
        );
      }).toList(),
    );
  }
}

class _Reviews extends StatelessWidget {
  const _Reviews({
    Key key,
  }) : super(key: key);

  Widget _buildSingleReview(String reviewText) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  border: Border.all(
                    width: 3.0,
                    color: Colors.grey,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      '5',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 36.0,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  reviewText,
                  style: const TextStyle(fontSize: 20.0, color: Colors.black87),
                  maxLines: null,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 8.0,
          color: Colors.grey[700],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Reviews',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        Column(
          children: StubData.reviewStrings
              .map((reviewText) => _buildSingleReview(reviewText))
              .toList(),
        ),
      ],
    );
  }
}
