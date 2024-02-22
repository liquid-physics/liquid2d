import 'package:flutter/material.dart';
import 'package:liquid2d_example/core/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // fullscreen
  // await windowManager.ensureInitialized();
  // await WindowManager.instance.setFullScreen(true);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) => routeGen(settings, context),
    );
  }
}
