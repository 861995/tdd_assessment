import 'package:flutter_test/flutter_test.dart';

String negativeThrowMsg = 'negatives not allowed';

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
    expect(calculator.add("//;\n1;2"), 3);
    expect(
      () => calculator.add("1,-2,3"),
      throwsA(
        predicate(
          (e) =>
              e is Exception &&
              e.toString().contains("negatives not allowed -2"),
        ),
      ),
    );
    expect(
      () => calculator.add("-1,-2,13"),
      throwsA(
        predicate(
          (e) =>
              e is Exception &&
              e.toString().contains("$negativeThrowMsg -1,-2"),
        ),
      ),
    );

    expect(calculator.add("1000,2"), 1002);
    expect(calculator.add("1003,2"), 2);
    expect(calculator.add("//[***]\n1***2***3"), 6);
    expect(calculator.add("//[abc]\n4abc5abc6"), 15);
    expect(calculator.add("//@\n2@4@6"), 12);
    expect(calculator.add("//%\n7%3%10"), 20);
    expect(calculator.add("//%7%3%10"), 20);
    expect(calculator.add("1\n2,3\n4,5"), 15);
    expect(calculator.add("//[***]\n1***2***3***4"), 10);
    expect(calculator.add("//[@#!]\n7@#!8@#!9"), 24);
    expect(calculator.add("2,1001,6"), 8);
    expect(
      () => calculator.add("1,-4,6,-9"),
      throwsA(
        predicate(
          (e) =>
              e is Exception &&
              e.toString().contains("negatives not allowed -4,-9"),
        ),
      ),
    );
    expect(
      () => calculator.add("//;\n1002;5;-3;2000;-7"),
      throwsA(
        predicate(
          (e) =>
              e is Exception &&
              e.toString().contains("negatives not allowed -3,-7"),
        ),
      ),
    );
    expect(calculator.add("1#2%3@4&5!6\n7,8"), 36);
    expect(calculator.add("10000"), 0);
    expect(calculator.add("1000"), 0);
    expect(calculator.add("999"), 999);
  });
}

class StringCalculator {
  int add(String numbers) {
    bool isDelimiterPresent = RegExp(
      r'(\n|//|;|\*|\[|\]|[A-Za-z]|#|@|%|&|!|,)',
    ).hasMatch(numbers);

    if (numbers.isEmpty) {
      // return 0 if the value is just '';
      return 0;
    } else if (isDelimiterPresent) {
      // Even the delimiter starts with '//' or not this condition will work & replace it to ','
      numbers = numbers.replaceAll(
        RegExp(r'(\n|//|;|\*|\[|\]|[A-Za-z]|#|@|%|&|!)'),

        ',',
      );

      List<String> splitNum = numbers.split(',');
      List<int> positiveNum = [];
      List<int> negativeNum = [];

      for (var splitNum in splitNum) {
        if (splitNum.isNotEmpty) {
          int parsedNum = int.parse(splitNum);

          if (!parsedNum.isNegative) {
            if (parsedNum <= 1000) {
              positiveNum.add(parsedNum);
            }
          } else {
            negativeNum.add(parsedNum);
          }
        }
      }
      if (negativeNum.isNotEmpty) {
        throw Exception("$negativeThrowMsg ${negativeNum.join(',')}");
      }
      return positiveNum.fold(0, (sum, element) => sum + element);
    } else {
      if (int.parse(numbers) >= 1000) {
        return 0;
      } else {
        // this will execute if there is only one number is there
        return int.parse(numbers);
      }
    }
  }
}
