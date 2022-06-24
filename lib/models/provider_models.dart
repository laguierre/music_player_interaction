import 'package:flutter/material.dart';

class GridChangeModel extends ChangeNotifier {
  bool _trigger = false;

  bool get trigger => _trigger;

  set trigger(bool trigger) {
    _trigger = trigger;
    notifyListeners();
  }
}