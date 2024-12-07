import 'package:custom_markers_tutorial/map/map_screen.dart';
import 'package:custom_markers_tutorial/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Marks on Google Map',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const MapScreen(),
        '/profile': (context) => const Profile()
      },
      navigatorKey: navigatorKey, // important

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
