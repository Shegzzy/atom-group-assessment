import 'package:atom_assessment/features/presentation/search_screen/search_screen.dart';
import 'package:atom_assessment/features/utils/api_client.dart';
import 'package:flutter/material.dart';

import 'features/utils/app_logger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiClient.instance.initializeDio();
  AppLogger.instance.initializeAppLogger();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atom Assessment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SearchScreen(),
    );
  }
}

