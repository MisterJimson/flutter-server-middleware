import 'package:flutter_server_middleware_example/models.dart';

Future<MovieReview> getMovieBySlug(String slug) async {
  // Fake api call
  await Future.delayed(const Duration(seconds: 1));
  return reviews.firstWhere((r) => r.slug == slug);
}

const reviews = [
  MovieReview(
    slug: 'avengers-endgame',
    title: 'Avengers: Endgame',
    review: 'Great movie! Crazy start to finish!',
    rating: 9,
  ),
  MovieReview(
    slug: 'eternal-Sunshine-of-the-spotless-mind',
    title: 'Eternal Sunshine of the Spotless Mind',
    review: 'Fantasic story, mind bending and amazing performances!',
    rating: 9,
  ),
  MovieReview(
    slug: 'the-shawshank-redemption',
    title: 'The Shawshank Redemption',
    review: 'Great movie! Love the ending.',
    rating: 9,
  ),
  MovieReview(
    slug: 'the-godfather',
    title: 'The Godfather',
    review: 'Great movie!',
    rating: 9,
  ),
];
