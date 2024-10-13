void main() {
  int num1 = 25;
  int num2 = 23;

  int add = num1 + num2;
  int sub = num1 - num2;
  int mul = num1 * num2;
  double div = num1 / num2;
  int divInt = num1 ~/ num2;

  print("Value of Num1 is: ${num1}");
  print("Value of Num2 is: ${num2}");
  print("");

  print("Addition of Num1 and Num2 is: ${add}");
  print("Subtraction of Num1 and Num2 is: ${sub}");
  print("Multiplication of Num1 and Num2 is: ${mul}");
  print("Division (Double) of Num1 and Num2 is: ${div.toStringAsFixed(2)}");
  print("Division (Integer) of Num1 and Num2 is: ${divInt}");
}
