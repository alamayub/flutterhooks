import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const imgHeight = 300.0;

extension Normalize on num {
  num normalize (
    num selfRangeMin,
    num selfRangeMax, [
    num normalizedrangeMin = 0.0,
    num normalizedrangeMax = 1.0
  ]) => (normalizedrangeMax - normalizedrangeMin) * ((this - selfRangeMin) / (selfRangeMax - selfRangeMin)) + normalizedrangeMin;
}

class AnumationHook extends HookWidget {
  const AnumationHook({super.key});

  @override
  Widget build(BuildContext context) {
    final opacity = useAnimationController(
      duration:const Duration(seconds: 1),
      initialValue: 1.0,
      upperBound: 1.0,
      lowerBound: 0.0,
    );
    final size = useAnimationController(
      duration:const Duration(seconds: 1),
      initialValue: 1.0,
      upperBound: 1.0,
      lowerBound: 0.0,
    );
    final controller = useScrollController();
    useEffect(() {
      controller.addListener(() {
        final newOpacity = max(imgHeight - controller.offset, 0.0);
        final normalized = newOpacity.normalize(0.0, imgHeight).toDouble();
        opacity.value = normalized;
        size.value = normalized;
      });
      return null;
    }, [controller]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Hook'),
      ),
      body: Column(
        children: [
          SizeTransition(
            sizeFactor: size,
            axis: Axis.vertical,
            axisAlignment: -1.0,
            child: FadeTransition(
              opacity: opacity,
              child: Container(
                color: Colors.purple,
                height: imgHeight,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 100,
              controller: controller,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('INDEX ${index + 1}'),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
