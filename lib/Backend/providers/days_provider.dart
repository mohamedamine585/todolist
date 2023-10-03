import 'package:flutter/material.dart';

import 'package:to_do_app/Backend/modules/Days.dart';
import 'package:to_do_app/Backend/usefulfunctions.dart';

class days_provider with ChangeNotifier {
  List<Day>? days;
  days_provider({required DateTime oldest}) {
    days = get_days(oldest: oldest);
  }

  void select_day({required int index}) {
    bool anyonetrue = false;
    for (int i = 0; i < days!.length; i++) {
      if (days![i].is_selected && index != i) {
        anyonetrue = true;
        days![i].is_selected = false;
      }
    }
    if (anyonetrue) {
      days![index].is_selected = !days![index].is_selected;
    }

    notifyListeners();
  }
}
