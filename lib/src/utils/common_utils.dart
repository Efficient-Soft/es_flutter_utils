import 'dart:convert';
import 'dart:developer';

import 'package:colorize/colorize.dart';

Future<void> awaitTwoMinutes() {
  return Future.delayed(Duration(seconds: 2));
}

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

List<List<T>> divideList<T>(List<T> inputList, int chunkSize) {
  List<List<T>> dividedList = [];
  for (int i = 0; i < inputList.length; i += chunkSize) {
    dividedList.add(
      inputList.sublist(
        i,
        i + chunkSize > inputList.length ? inputList.length : i + chunkSize,
      ),
    );
  }
  return dividedList;
}

dynamic mergeTwoMap(dynamic a, dynamic b) {
  dynamic parse(dynamic v) {
    if (v == null) return null;

    if (v is String) {
      try {
        return jsonDecode(v);
      } catch (_) {
        return null;
      }
    }

    if (v is Map || v is List) return v;

    return null;
  }

  final x = parse(a);
  final y = parse(b);

  if (x == null) return y;
  if (y == null) return x;

  if (x is Map && y is Map) {
    final result = Map<String, dynamic>.from(x);

    y.forEach((key, value) {
      final k = key.toString();
      result[k] = result.containsKey(k)
          ? mergeTwoMap(result[k], value)
          : parse(value) ?? value;
    });

    return result;
  }

  if (x is List && y is List) {
    if (!x.every((e) => parse(e) is Map)) return x;
    if (!y.every((e) => parse(e) is Map)) return x;
    return [
      for (var i = 0; i < x.length || i < y.length; i++)
        if (i < x.length && i < y.length)
          mergeTwoMap(x[i], y[i])
        else if (i < x.length)
          x[i]
        else
          y[i],
    ];
  }

  return x;
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
