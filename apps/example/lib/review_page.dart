import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_server_middleware_example/api.dart';
import 'package:flutter_server_middleware_example/models.dart';
import 'package:flutter_server_middleware_example/util.dart';

class ReviewPage extends StatefulWidget {
  final String slug;

  const ReviewPage({
    Key? key,
    required this.slug,
  }) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late MovieReview review;
  bool isLoading = true;

  @override
  void initState() async {
    super.initState();

    var reviewData = await getData();
    setState(() {
      isLoading = false;
      review = reviewData;
    });
  }

  FutureOr<MovieReview> getData() async {
    var middlewareData = getMiddlewareData();
    if (middlewareData == null) {
      var data = await getMovieBySlug(widget.slug);
      return data;
    } else {
      return MovieReview.fromJson(middlewareData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jason's Movie Reviews")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    review.title,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    review.review,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
      ),
    );
  }
}
