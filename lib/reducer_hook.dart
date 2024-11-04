import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum Action {
  reset,
  rotateLeft,
  rotateRight,
  lessVisible,
  moreVisible,
}

@immutable
class State {
  final double rotationDeg;
  final double alpha;

  const State({
    required this.rotationDeg, 
    required this.alpha
  });

  const State.zero() : rotationDeg = 0.0, alpha = 1.0;
  State reset() => State(rotationDeg: 0.0, alpha: 1.0);
  State rotateRight() => State(rotationDeg: rotationDeg + 10.0, alpha: alpha);
  State rotateLeft() => State(rotationDeg: rotationDeg - 10.0, alpha: alpha);
  State increaseAlpha() => State(rotationDeg: rotationDeg, alpha: min(alpha + 0.1, 1.0));
  State decreaseAlpha() => State(rotationDeg: rotationDeg, alpha: max(alpha - 0.1, 0.0));
}

State reducer(State oldState, Action? action) {
  switch (action) {
    case Action.reset:
      return oldState.reset();
    case Action.rotateLeft:
      return oldState.rotateLeft();
    case Action.rotateRight:
      return oldState.rotateRight();
    case Action.moreVisible:
      return oldState.increaseAlpha();
    case Action.lessVisible:
      return oldState.decreaseAlpha();
    case null:
      return oldState;
  }
}

class ReducerHook extends HookWidget {
  const ReducerHook({super.key});

  @override
  Widget build(BuildContext context) {
    final store = useReducer<State, Action?>(
      reducer, 
      initialState: const State.zero(), 
      initialAction: null
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Reducer Hook'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: Action.values.length,
              itemBuilder: (context, index) => TextButton(
                  onPressed: () => store.dispatch(Action.values[index]),
                  child: Text(Action.values[index].toString()),
                ),
            ),
          ),
          Expanded(
            child: Opacity(
              opacity: store.state.alpha,
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(store.state.rotationDeg / 360.0),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
