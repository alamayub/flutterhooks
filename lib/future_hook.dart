import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E> ([
    E? Function(T?)? transform
  ]) => map(transform ?? (e) => e).where((e) => e != null).cast();
}

const url = 'https://bit.ly/3qYOtDm';

class FutureHook extends HookWidget {
  const FutureHook({super.key});

  @override
  Widget build(BuildContext context) {
    final image = useFuture(NetworkAssetBundle(Uri.parse(url))
      .load(url)
      .then((data) => data.buffer.asUint8List())
      .then((data) => Image.memory(data)));
    return Scaffold(
      appBar: AppBar(
        title: Text('Future Hook ${image.connectionState}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            image.hasData ? image.data : null
          ].compactMap().toList(),
        ),
      ),
    );
  }
}