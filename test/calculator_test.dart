import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Calculator test', () {
    final calculator = StringCalculator();
    expect(calculator.add(""), 0);
  });
}

class StringCalculator {
  int add(String numbers) {
    return 0;
  }
}
