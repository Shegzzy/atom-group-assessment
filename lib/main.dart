import 'package:atom_assessment/features/presentation/search_screen/search_screen.dart';
import 'package:atom_assessment/features/utils/api_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import 'features/data/viewmodels/search_vm.dart';
import 'features/utils/app_logger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiClient.instance.initializeDio();
  AppLogger.instance.initializeAppLogger();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SearchCompanyVm()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Atom Assessment',
        theme: _buildTheme(Brightness.light),
        builder: (context, child){
          final mediaQueryData = MediaQuery.of(context);
          final scale = mediaQueryData.textScaler.clamp(minScaleFactor: 1.0, maxScaleFactor: 1.3);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: scale),
            child: child!,
          );
        },
        home: const SearchScreen(),
      )
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final ThemeData baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
    );
  }
}

