import 'package:flutter/material.dart';

PageRouteBuilder changePage(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 1000),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Animatable<Offset> animatable =
          Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.ease));
      return SlideTransition(
        position: animatable.animate(animation),
        child: child,
      );
    },
  );
}
