import 'package:flutter/material.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  const NoGlowScrollBehavior();
  @override
  Widget buildViewportChrome(BuildContext _, Widget child, AxisDirection __) =>
      child;
}
