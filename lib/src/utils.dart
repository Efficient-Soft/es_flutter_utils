import 'dart:developer';
import 'dart:math' as math;

import 'package:colorize/colorize.dart';
import 'package:es_flutter_utils/src/models/widget_metadata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

T? consumeException<T>(
  T? Function() fun, {
  void Function(Object e, StackTrace s)? onError,
}) {
  try {
    return fun();
  } catch (e, s) {
    onError?.call(e, s);
  }
  return null;
}

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
  // final numberFormat = NumberFormat("###,###,###,###,###,###.##");
  final numberFormat = NumberFormat("#,##0.##", locale);
  return numberFormat.format(number);
}

void registerPostFrameCallback(VoidCallback callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) => callback());
}

Offset? getWidgetPosition(GlobalKey key) {
  final RenderBox? renderBox =
      key.currentContext?.findRenderObject() as RenderBox?;
  if (renderBox != null) {
    return renderBox.localToGlobal(Offset.zero);
  }
  return null;
}

WidgetMetaData? getWidgetMetaData(GlobalKey key) {
  try {
    final RenderBox renderBox =
        key.currentContext?.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);

    return WidgetMetaData(
      position: offset,
      size: renderBox.size,
      constraints: renderBox.constraints,
    );
  } catch (e) {
    return null;
  }
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

Color getColorFromName(String colorName) {
  final colorMap = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'black': Colors.black,
    'white': Colors.white,
    'gray': Colors.grey,
    'silver': const Color(0xFFC0C0C0),
    'gold': const Color(0xFFFFD700),
    'orange': Colors.orange,
    'purple': Colors.purple,
    'pink': Colors.pink,
    'brown': Colors.brown,
    'maroon': const Color(0xFF800000),
    'navy': const Color(0xFF000080),
    'beige': const Color(0xFFF5F5DC),
    'ivory': const Color(0xFFFFFFF0),
    'charcoal': const Color(0xFF36454F),
    'lime': const Color(0xFFBFFF00),
    'teal': Colors.teal,
    'cyan': Colors.cyan,
    'magenta': const Color(0xFFFF00FF),
    'bronze': const Color(0xFFCD7F32),
    'champagne': const Color(0xFFF7E7CE),
    'pearl': const Color(0xFFEAE0C8),
    'turquoise': const Color(0xFF40E0D0),
    'mint': const Color(0xFF98FF98),
    'indigo': const Color(0xFF4B0082),
    'olive': const Color(0xFF808000),
  };

  return colorMap[colorName.toLowerCase()] ?? Colors.transparent;
}

String formatDurationObj(Duration duration) {
  return DateFormat('hh:mm a').format(DateTime.now().add(duration));
}

Future<void> callPhoneNumber(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  try {
    await launchUrl(phoneUri);
  } catch (e) {
    printLog(e);
  }
}

int get6RandomNumber() {
  var rnd = math.Random();
  return 100000 + rnd.nextInt(900000);
}

double mapValue(
  double value,
  double inMin,
  double inMax,
  double outMin,
  double outMax,
) {
  return (value - inMin) / (inMax - inMin) * (outMax - outMin) + outMin;
}

void vibrateLightImpact() {
  HapticFeedback.lightImpact();
}

void printLog(dynamic d, {StackTrace? s, String? tag}) {
  final stacktrace = StackTrace.current;
  final stackLines = stacktrace.toString().split('\n');
  final callerInfo = stackLines.length > 1 ? stackLines[1] : 'Unknown';
  final mtag = callerInfo.split('(').first.trim();
  log(
    Colorize(
      '${'$mtag ${tag ?? ''}'} : $d, \n ${s != null ? 'stackTrace $s' : ''} ',
    ).lightMagenta().toString(),
  );
}

SliverList testSliverList() => SliverList.builder(
  addAutomaticKeepAlives: false,
  itemBuilder: (context, index) => ListTile(title: Text(index.toString())),
);

const String longLoremString = '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Curabitur pretium tincidunt lacus. Nulla gravida orci a odio. Nullam varius, turpis et commodo pharetra, est eros bibendum elit, nec luctus magna felis sollicitudin mauris. Integer in mauris eu nibh euismod gravida. Duis ac tellus et risus vulputate vehicula. Donec lobortis risus a elit. Etiam tempor. Ut ullamcorper, ligula eu tempor congue, eros est euismod turpis, id tincidunt sapien risus a quam. Maecenas fermentum consequat mi. Donec fermentum. Pellentesque malesuada nulla a mi. Duis sapien sem, aliquet nec, commodo eget, consequat quis, neque. Aliquam faucibus, elit ut dictum aliquet, felis nisl adipiscing sapien, sed malesuada diam lacus eget erat.

Cras mollis scelerisque nunc. Nullam arcu. Aliquam consequat. Curabitur augue lorem, dapibus quis, laoreet et, pretium ac, nisi. Aenean magna nisl, mollis quis, molestie eu, feugiat in, orci. In hac habitasse platea dictumst. Fusce convallis, mauris imperdiet gravida bibendum, nisl turpis suscipit mauris, sed placerat dui dolor sit amet urna. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Fusce id purus. Ut varius tincidunt libero. Phasellus dolor. Maecenas vestibulum mollis diam. Pellentesque ut est.

Praesent tristique eros in metus ullamcorper, non hendrerit orci pulvinar. Sed auctor ac turpis nec placerat. Maecenas id orci nisi. Nullam id dolor at mi luctus feugiat ut in risus. Vestibulum tristique ante non magna faucibus, id bibendum orci dapibus. Quisque pharetra est in arcu interdum condimentum. Mauris vitae augue augue. Fusce vel risus nec erat ultricies ullamcorper. Nulla porttitor erat eu risus viverra, vel sollicitudin sapien tempor. Nulla facilisi. Duis euismod, felis eget congue laoreet, sapien magna sollicitudin lorem, id cursus felis odio a purus. Vestibulum egestas sapien in odio placerat, at pharetra odio tincidunt.

Vestibulum eu odio vel lacus laoreet fermentum. Cras in leo metus. Nullam tristique faucibus nisl ac hendrerit. Donec ornare lectus urna, ut vestibulum purus commodo ut. Nulla a arcu ut arcu elementum viverra. In consequat orci ut erat condimentum, sed malesuada odio bibendum. Nunc auctor id turpis id efficitur. Mauris egestas elit eget lectus pharetra, sed suscipit odio viverra. Curabitur sit amet eros auctor, vehicula turpis in, accumsan risus. Suspendisse potenti. Integer sollicitudin justo ut justo cursus, eget lacinia odio consectetur. Curabitur nec orci eget orci dapibus sollicitudin nec non arcu. Curabitur at nunc et elit fringilla suscipit id eget sem. Integer scelerisque aliquet odio id pharetra. Donec consequat sit amet lacus ac posuere.
''';

Color generateRandomColor() {
  return Color(math.Random().nextInt(0xffffff + 1) | 0xff000000);
}
