import 'package:flutter/material.dart';
import 'package:flutter_server_middleware_example/api.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jason's Movie Reviews")),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (_, index) {
          var review = reviews[index];
          return ListTile(
            title: Text(review.title),
            onTap: () => context.push(
              '/review/${review.slug}',
            ),
          );
        },
      ),
    );
  }
}
