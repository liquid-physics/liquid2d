import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class FpsCounter extends StatefulWidget {
  const FpsCounter({
    super.key,
    required this.renderUpdate,
  });

  final Stream<double> renderUpdate;

  @override
  State<FpsCounter> createState() => _FpsCounterState();
}

class _FpsCounterState extends State<FpsCounter> {
  double fps = 0;
  @override
  void initState() {
    super.initState();
    widget.renderUpdate.throttleTime(const Duration(milliseconds: 500)).listen((event) {
      setState(() {
        fps = 1 / event;
        if (fps.isNaN || fps.isInfinite) {
          fps = 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${fps.round()}',
      style: const TextStyle(color: Colors.white),
    );
  }
}
