import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper(
      {super.key, required this.child, required this.nextScreen});

  final Widget child;
  final Widget nextScreen;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      closedColor: const Color(0xFFE5E6E8),
      transitionType: ContainerTransitionType.fade,
      transitionDuration: const Duration(milliseconds: 850),
      closedBuilder: (_, VoidCallback openContainer) {
        return InkWell(
          onTap: openContainer,
          child: child,
        );
      },
      openBuilder: (_, __) => nextScreen,
    );
  }
}
