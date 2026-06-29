import 'package:url_launcher/url_launcher.dart';
import 'common_utils.dart';

bool validatePhoneNumber(String phoneNumber) {
  return RegExp(r'^(?:\+959|09)[0-9]{9,}$').hasMatch(phoneNumber);
}

Future<void> callPhoneNumber(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  try {
    await launchUrl(phoneUri);
  } catch (e) {
    printLog(e);
  }
}
