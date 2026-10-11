import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class AnimationCourse extends StatefulWidget {
  const AnimationCourse({super.key});

  @override
  State<AnimationCourse> createState() => _AnimationCourseState();
}

class _AnimationCourseState extends State<AnimationCourse>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Offset position = Offset.zero;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    controller.addListener(() {
      setState(() {
        position = Offset(controller.value, 0);
      });
    });
  }

  // void _onTapDown(TapDownDetails? details) {
  //   controller.animateTo(0.8, duration: Duration(milliseconds: 100));
  // }

  // void _onTapUp(TapUpDetails? details) {
  //   final spring = SpringSimulation(
  //     SpringDescription(mass: 1, stiffness: 300, damping: 10),
  //     controller.value,
  //     1,
  //     0,
  //   );
  //   controller.animateWith(spring);
  // }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      position += details.delta;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final simulation = SpringSimulation(
      SpringDescription(mass: 1, stiffness: 300, damping: 12),
      0,
      0,
      0,
    );
    controller.animateWith(simulation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: Transform.translate(
            offset: position,
            child: Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
