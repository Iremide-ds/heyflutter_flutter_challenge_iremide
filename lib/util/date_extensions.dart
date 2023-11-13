extension DateExts on DateTime {
  String get toMMDD {
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    String month1 = months[month - 1];
    String day1 = day.toString().padLeft(2, '0');

    return '$month1 $day1';
  }

  String get toDDMM {
    List<String> daysOftheWeek = [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat'
    ];

    String day1 = daysOftheWeek[weekday - 1];

    return '$day1 ${month.toString().padLeft(2, '0')}';
  }

  String get format {
    String year1 = year.toString();
    String month1 = month.toString().padLeft(2, '0');
    String day1 = day.toString().padLeft(2, '0');
    String hour1 = hour.toString().padLeft(2, '0');
    String minute1 = minute.toString().padLeft(2, '0');

    String period = (hour < 12) ? 'AM' : 'PM';
    if (hour > 12) {
      hour1 = (hour - 12).toString().padLeft(2, '0');
    } else if (hour == 0) {
      hour1 = '12';
    }

    return '$year1/$month1/$day1 $hour1:$minute1 $period';
  }
}
