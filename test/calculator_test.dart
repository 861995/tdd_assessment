import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Calculator test', () {
    final calculator = StringCalculator();
    expect(calculator.add(""), 0);
    expect(calculator.add("1"), 1);
    expect(calculator.add("2"), 2);
  });
}

class StringCalculator {
  int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    } else {
      return int.parse(numbers);
    }
  }
}
