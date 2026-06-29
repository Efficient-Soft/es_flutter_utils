import 'dart:math' as math;

double degreeToRadian(double degree) => degree * (math.pi / 180);

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
