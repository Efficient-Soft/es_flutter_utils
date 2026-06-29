import 'package:intl/intl.dart';

String formatNumber(num value) {
  final numFormat = NumberFormat("#,##0", "en_US");
  final numFormatForPoint = NumberFormat("#,##0.00", "en_US");
  if (value == value.toInt()) {
    return numFormat.format(value);
  } else {
    return numFormatForPoint.format(value);
  }
}

String formatCurrencyAmount(num number, {String locale = 'en'}) {
  final numberFormat = NumberFormat("#,##0.##", locale);
  return numberFormat.format(number);
}

String formatDuration(int totalDurationInSec) {
  final duration = Duration(seconds: totalDurationInSec);
  final hours = duration.inHours;
  final minutes = duration.inMinutes % 60;

  if (hours >= 1) {
    if (minutes > 0) {
      return '$hours hr $minutes min';
    } else {
      return '$hours hr';
    }
  } else if (duration.inMinutes >= 1) {
    return '${duration.inMinutes} min';
  } else {
    return '${duration.inSeconds} sec';
  }
}

String formatDistance(int totalDistanceInMeter) {
  if (totalDistanceInMeter < 100) {
    return '${totalDistanceInMeter.toStringAsFixed(0)} m';
  } else {
    double km = totalDistanceInMeter / 1000;
    return '${km.toStringAsFixed(1)} km';
  }
}

String formatDurationObj(Duration duration) {
  return DateFormat('hh:mm a').format(DateTime.now().add(duration));
}
