// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movielix/app_constants.dart';

import 'package:movielix/main.dart';
import 'package:movielix/movie/repositories/movie_repositories_impl.dart';
import 'package:movielix/tv/repositories/tv_repositories_impl.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Setup MovieRepositories instance
    final dioOptions = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      queryParameters: {'api_key': AppConstants.apiKey},
    );
    final Dio dio = Dio(dioOptions);
    final movieRepositories = MovieRepositoriesImpl(dio);
    final tvRepositories = TvRepositoriesImpl(dio);

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      movieRepositories: movieRepositories,
      tvRepositories: tvRepositories,
    ));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
