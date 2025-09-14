import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Calculator test', () {
    final calculator = StringCalculator();
    expect(calculator.add(""), 0);
    expect(calculator.add("1"), 1);
    expect(calculator.add("2"), 2);
    expect(calculator.add("3"), 3);
    expect(calculator.add("4"), 4);
    expect(calculator.add("1,2"), 3);
    expect(calculator.add("1,25"), 26);
    expect(calculator.add("100,250"), 350);
    expect(calculator.add("1,2,3,4,5"), 15);
    expect(calculator.add("1\n2,3,4,5"), 15);
    expect(calculator.add("1,\n2,3,4,5"), 15);
    expect(calculator.add("1,\n\n2,3,\n4,5"), 15);
  });
}

class StringCalculator {
  int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    } else if (numbers.contains(',') || numbers.contains('\n')) {
      if (numbers.contains('\n')) {
        numbers = numbers.replaceAll('\n', ',');
      } else {}

      List<String> splittedNum = numbers.split(',');
      List<int> nums = [];
      for (var splitNum in splittedNum) {
        if (splitNum.isNotEmpty) {
          nums.add(int.parse(splitNum));
        }
      }
      return nums.fold(0, (sum, element) => sum + element);
    }
    return int.parse(numbers);
  }
}
