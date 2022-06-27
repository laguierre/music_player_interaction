import 'package:flutter/material.dart';
import 'package:music_player_interaction/constants.dart';

class GridChangeModel extends ChangeNotifier {
  int _state = 0;
  bool _triggerROT = false;

  int get state => _state;
  bool get triggerROT => _triggerROT;


  set triggerROT(bool trigger) {
    _triggerROT = trigger;
    notifyListeners();
  }

  set state(int state) {
    _state = state;
    notifyListeners();
  }

  void DiscAppear() {
    _triggerROT = false;
    _state = 2;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: kDelayAnimation), () {
      _state = 1;
      _triggerROT = true;
      notifyListeners();
    });
  }
}

class PlayPageModel extends ChangeNotifier {
  int _state = -1;
  int get state => _state;

  set state(int state) {
    _state = state;
    notifyListeners();
  }
}
