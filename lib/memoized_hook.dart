import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E> ([
    E? Function(T?)? transform
  ]) => map(transform ?? (e) => e).where((e) => e != null).cast();
}

const url = 'https://bit.ly/3qYOtDm';

class MemoizedHook extends HookWidget {
  const MemoizedHook({super.key});

  @override
  Widget build(BuildContext context) {
    final future = useMemoized(() => NetworkAssetBundle(Uri.parse(url))
      .load(url)
      .then((data) => data.buffer.asUint8List())
      .then((data) => Image.memory(data, )), []);
    final snapshot = useFuture(future);
    return Scaffold(
      appBar: AppBar(
        title: Text('Memoized Hook'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [snapshot.data].compactMap().toList(),
        ),
      ),
    );
  }
}