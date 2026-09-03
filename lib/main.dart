import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kauto/firebase_options.dart';
import 'package:kauto/presentation/products/providers/theme_provider.dart';
import 'package:kauto/presentation/wrapper/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffF5F5FA),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xffF5F5FA)),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF121212),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFF121212)),
        cardColor: Color(0xFF1E1E1E),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.grey.shade400),
        ),
        colorScheme: ColorScheme.dark(primary: Color.fromRGBO(79, 57, 246, 1)),
      ),
      themeMode: themeMode,
      home: Wrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}
