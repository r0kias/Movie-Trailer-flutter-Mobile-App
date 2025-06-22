import 'package:flutter/material.dart';
// import 'package:secondd_ui/service/dependancy.dart';
// import 'package:secondd_ui/widget/retry_pop.dart';
// import 'package:secondd_ui/pages/moviedetail.dart';
// import 'package:secondd_ui/pages/search_page.dart';

import 'pages/homepage.dart';

void main() {
  runApp(const MyApp());
  // DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: Homepage(),
      // home: RetryPop(),
    );
  }
}
