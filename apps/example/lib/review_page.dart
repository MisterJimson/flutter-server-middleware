import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_server_middleware_example/api.dart';
import 'package:flutter_server_middleware_example/models.dart';
import 'package:flutter_server_middleware_example/util.dart';
import 'package:go_router/go_router.dart';

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

  // for demo purposes, hide page content for refresh testing
  bool setAllContentBlank = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    MovieReview reviewData;

    var middlewareData = getMiddlewareData();
    if (middlewareData == null) {
      reviewData = await getMovieBySlug(widget.slug);
    } else {
      reviewData = MovieReview.fromJson(middlewareData);
    }

    setState(() {
      isLoading = false;
      review = reviewData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return setAllContentBlank
        ? Container(
            color: Colors.white,
          )
        : _buildReview(context);
  }

  Widget _buildReview(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: const Text("Jason's Movie Reviews"),
          onTap: () {
            GoRouter.of(context).go('/');
          },
        ),
      ),
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
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        setAllContentBlank = true;
                      });
                    },
                    child: const Text("Set all content blank for testing"),
                  )
                ],
              ),
      ),
    );
  }
}
