void main() {
  ///1. input จะต้องมีความยาวมากกว่าหรือเท่ากับ 6 ตัวอักษร เช่น
  /// 17283 ❌
  /// 172839 ✅
  print('${checkInputLength("172839")}');

  /// input จะต้องกันไม่ให้มีเลขซ้ำติดกันเกิน 2 ตัว
  /// 118822 ❌
  /// 111762 ✅
  print('${checkDuplicateNumbers("111762")}');

  ///input จะต้องกันไม่ให้มีเลขเรียงกันเกิน 2 ตัว
  /// 123743 ❌
  /// 321895 ❌
  /// 124578 ✅
  print('${checkConsecutiveNumbers('124578')}');

  ///input จะต้องกันไม่ให้มีเลขชุดซ้ำ เกิน 2 ชุด
  /// 112233 ❌
  /// 882211 ❌
  /// 887712 ✅
  print('${checkDuplicateSets('882211')}');
}

bool checkInputLength(String input) {
  return input.length >= 6;
}

bool checkDuplicateNumbers(String input) {
  for (int i = 0; i < input.length - 2; i++) {
    if (input[i] == input[i + 1] && input[i + 2] == input[i + 3]) {
      return false;
    }
  }
  return true;
}

bool checkConsecutiveNumbers(String input) {
  for (int i = 0; i < input.length - 2; i++) {
    int currentNumber = int.parse(input[i]);
    int nextNumber = int.parse(input[i + 1]);
    int nextNextNumber = int.parse(input[i + 2]);

    if (currentNumber + 1 == nextNumber && nextNumber + 1 == nextNextNumber) {
      return false;
    } else if (currentNumber - 1 == nextNumber &&
        nextNumber - 1 == nextNextNumber) {
      return false;
    }
  }
  return true;
}

bool checkDuplicateSets(String input) {
  int i = 0;
  if (input[i] == input[i + 1] &&
      input[i + 2] == input[i + 3] &&
      input[i + 4] == input[i + 5]) {
    return false;
  }
  return true;
}
