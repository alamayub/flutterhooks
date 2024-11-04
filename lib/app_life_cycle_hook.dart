import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class AppLifeCycleHook extends HookWidget {
  const AppLifeCycleHook({super.key});

  @override
  Widget build(BuildContext context) {
    final state = useAppLifecycleState();
    return Scaffold(
      appBar: AppBar(
        title: Text('App Life Cycle Hook'),
      ),
      body: Center(
        child: Opacity(
          opacity: state == AppLifecycleState.resumed ? 1.0 : 0.0,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}
