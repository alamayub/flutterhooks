import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Stream<String> getTime() => Stream.periodic(
  const Duration(seconds: 1), 
  (_) => DateTime.now().toIso8601String(),
);

class StreamHook extends HookWidget {
  const StreamHook({super.key});

  @override
  Widget build(BuildContext context) {
    final dateTime = useStream(
      getTime(), 
      initialData: DateTime.now().toIso8601String(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Hook'),
      ),
      body: Center(
        child: Text(dateTime.data ?? ''),
      ),
    );
  }
}