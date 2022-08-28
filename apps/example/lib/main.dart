import 'package:flutter/material.dart';
import 'package:flutter_server_middleware_example/home_page.dart';
import 'package:flutter_server_middleware_example/review_page.dart';
import 'package:go_router/go_router.dart';

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
          return ReviewPage(slug: state.params['slug']!);
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
      title: "Jason's Movie Reviews",
    );
  }
}
