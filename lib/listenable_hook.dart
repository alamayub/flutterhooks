import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class CountDown extends ValueNotifier<int> {
  late StreamSubscription sub;
  CountDown({required int from}) : super(from) {
    sub = Stream.periodic(
      const Duration(seconds: 1), 
      (v) => from -v
    ).takeWhile((value) => value >=0).listen((value) {
      this.value =value;
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}


class ListenableHook extends HookWidget {
  const ListenableHook({super.key});

  @override
  Widget build(BuildContext context) {
    final countDown = useMemoized(() => CountDown(from: 50));
    final notifier = useListenable(countDown);
    return Scaffold(
      appBar: AppBar(
        title: Text('Listenable Hook'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Text(notifier.value.toString()),
      ),
    );
  }
}