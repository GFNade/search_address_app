import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/search_provider.dart';
import 'screens/search_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchProvider(),
      child: const MaterialApp(
        localizationsDelegates: [ 
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [ 
          Locale('vi', ''), // Vietnamese
        ],
        home: SearchScreen(),
      ),
    );
  }
}