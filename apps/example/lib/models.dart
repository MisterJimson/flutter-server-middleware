class MovieReview {
  final String slug;
  final String title;
  final String review;
  final int rating;

  const MovieReview({
    required this.slug,
    required this.title,
    required this.review,
    required this.rating,
  });

  factory MovieReview.fromJson(Map<String, dynamic> json) => MovieReview(
        slug: json["slug"],
        title: json["title"],
        review: json["review"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "title": title,
        "review": review,
        "rating": rating,
      };
}
