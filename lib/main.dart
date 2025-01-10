import 'package:flutter/material.dart';
import 'package:pr_6_space_app/controller/data_provider.dart';
import 'package:pr_6_space_app/controller/homeProvider.dart';
import 'package:pr_6_space_app/screens/favourite/like_screen.dart';
import 'package:pr_6_space_app/screens/home/home_screen.dart';
import 'package:pr_6_space_app/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlanetProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
      ],
      child: const SpaceApp(),
    ),
  );
}

class SpaceApp extends StatelessWidget {
  const SpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, value, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        theme: ThemeData.light(),
        themeMode: context.read<HomeProvider>().isDarkTheme
            ? ThemeMode.dark
            : ThemeMode.light,
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(),
          '/fav': (context) => const LikeScreen(),
        },
      ),
    );
  }
}
