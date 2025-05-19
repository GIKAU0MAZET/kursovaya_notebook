import 'package:flutter/material.dart';

abstract final class NavigationKey {
  static final GlobalKey<NavigatorState> root = GlobalKey();
  static final rootKey = GlobalKey<NavigatorState>();
  static final dashboardKey = GlobalKey<NavigatorState>();
  static final publicKey = GlobalKey<NavigatorState>();
}
