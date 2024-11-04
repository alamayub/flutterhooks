import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const url = 'https://bit.ly/3x7J5Qt';

class StramControllerHook extends HookWidget {
  const StramControllerHook({super.key});

  @override
  Widget build(BuildContext context) {
    late final StreamController<double> controller;
    controller = useStreamController<double>(
      onListen: () {
        controller.sink.add(0.0);
      }
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Stram Controller Hook'),
      ),
      body: StreamBuilder<double>(
        stream: controller.stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final rotation = snapshot.data ?? 0.0;
          return GestureDetector(
            onTap: () {
              controller.sink.add(rotation +10.0);
            },
            child: RotationTransition(
              turns:  AlwaysStoppedAnimation(rotation / 360.0),
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.purple,
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
