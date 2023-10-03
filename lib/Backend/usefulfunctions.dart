import 'package:to_do_app/Backend/modules/Days.dart';
import 'package:to_do_app/Backend/modules/Task.dart';

List<String> to_string_list({required List<dynamic> list}) {
  return List.generate(list.length, (index) {
    return list.elementAt(index);
  });
}

List<Day> get_days({required DateTime oldest}) {
  DateTime today = DateTime.now();
  List<Day> days = [];

  while (oldest.isBefore(today.add(Duration(days: 60)))) {
    if (oldest.day == today.day &&
        today.month == oldest.month &&
        oldest.year == today.year) {
      Day this_d = Day(date: today);
      this_d.is_selected = true;
      days.add(this_d);
    } else {
      days.add(Day(date: oldest));
    }

    oldest = oldest.add(Duration(days: 1));
  }
  return days;
}

DateTime genereate_olddays({required List<Task> tasks}) {
  List<DateTime> days = [];
  tasks.forEach((element) {
    if (!days.contains(element.date)) {
      days.add(element.date);
    }
  });
  DateTime oldest = DateTime.now();
  days.forEach((element) {
    if (element.isBefore(oldest)) {
      oldest = element;
    }
  });
  return oldest;
}

void Color_card({required int index, required List<Day> days}) {
  for (int i = 0; i < days.length; i++) {
    if (i == index) {
      days.elementAt(index).is_selected = !days.elementAt(index).is_selected;
    } else {
      days.elementAt(index).is_selected = false;
    }
  }
}

Map<int, String> months = {
  1: "Jan",
  2: "Fab",
  3: "Mar",
  4: "Avr",
  5: "Mai",
  6: "Jun",
  7: "Jul",
  8: "Aug",
  9: "Sep",
  10: "Oct",
  11: "Nov",
  12: "Dec",
};
