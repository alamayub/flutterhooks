import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hooks',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

Stream<String> getTime() => Stream.periodic(
  const Duration(seconds: 1), 
  (_) => DateTime.now().toIso8601String(),
);

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dateTime = useStream(
      getTime(), 
      initialData: DateTime.now().toIso8601String(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(dateTime.data ?? 'Home Screen'),
      ),
    );
  }
}