import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const String title = 'Jason\'s Movie Reviews';

void main() => runApp(App());

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final _router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/review/:slug',
        builder: (context, state) {
          final review =
              reviews.firstWhere((r) => r.slug == state.params['slug']);
          return ReviewPage(review: review);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: title,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      body: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (_, index) {
            var review = reviews[index];
            return ListTile(
              title: Text(review.movieTitle),
              onTap: () => context.push(
                '/review/${review.slug}',
              ),
            );
          }),
    );
  }
}

class ReviewPage extends StatelessWidget {
  final MovieReview review;

  const ReviewPage({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              review.movieTitle,
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

class MovieReview {
  final String slug;
  final String movieTitle;
  final String review;
  final int rating;

  const MovieReview(
    this.slug,
    this.movieTitle,
    this.review,
    this.rating,
  );
}

const reviews = [
  MovieReview('avengers-endgame', 'Avengers: Endgame',
      'Great movie! Crazy start to finish!', 9),
  MovieReview(
      'eternal-Sunshine-of-the-spotless-mind',
      'Eternal Sunshine of the Spotless Mind',
      'Fantasic story, mind bending and amazing performances!',
      9),
  MovieReview('the-shawshank-redemption', 'The Shawshank Redemption',
      'Great movie! Love the ending.', 9),
  MovieReview('the-godfather', 'The Godfather', 'Great movie!', 9),
];
