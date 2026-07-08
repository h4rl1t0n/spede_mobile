import 'package:flutter/material.dart';

extension OrientationExtensions on BuildContext {
  bool get isPortrait => MediaQuery.of(this).orientation == Orientation.portrait;
}
