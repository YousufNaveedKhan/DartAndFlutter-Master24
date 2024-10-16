// Task given for "ListMaster" by ChatGPT:

// 1. Create a list with 10 numbers (integers).
// 2. Apply basic arithmetic operations (+, -, *, /, %) to each number and print the results.
// 3. Find and print the largest and smallest number in the list.
// 4. Add all the numbers in the list and print the sum.
// 5. If the sum is greater than 100, use a conditional statement to print the message "Sum is greater than 100."
// 6. For each element in the list, check if it's odd or even, and print "Odd number" or "Even number" accordingly.
// 7. Use a loop to traverse the list and print the square of each element (number * number).

// This is your program's core requirement.
import 'dart:math';

void main() {
  // 1. List Creation
  List<int> numList = [3, 9, 10, 13, 2, 5, 8, 1, 7, 4];

  // 2. Performing arithmetic operations to each number and print the results
  for (int i = 0; i  < numList.length - 1; i++) {
    print("Addition: ${numList[i]} + ${numList[i+1]} = ${numList[i] + numList[i+1]}");
    print("Subtraction: ${numList[i]} - ${numList[i+1]} = ${numList[i] - numList[i+1]}");
    print("Multiplication: ${numList[i]} * ${numList[i+1]} = ${numList[i] * numList[i+1]}");
    print("Division: ${numList[i]} / ${numList[i+1]} = ${(numList[i] / numList[i+1]).toStringAsFixed(2)}");
    print("");
  }

  // 3. Finding and printing the largest and smallest number in the list
  print("The largest number in the list is: ${numList.reduce(max)}");
  print("The smallest number in the list is: ${numList.reduce(min)}");

  // 4. Adding all the numbers in the list and printing the sum
  int sum = numList.reduce((a, b) => a +b);
  print("\nSum of all numbers in the list: ${sum}");

  // 5. Applying the condition to print the message if "Sum is greater than 100."
  if (sum > 100) {
    print("\nSum is greater than 100.");
  }else {
    print("\nSum is not greater than 100.");
  }

  // 6. Checking each element if it's odd or even
  print("\nEven/Odd Check:");
  numList.forEach((num) {
    if (num % 2 == 0) {
      print("${num} is even number");
    }else {
      print("${num} is odd number");
    }
  });
  // 7. Using a loop to print the square of each element (number * number)
  print("\nSquare of each element:");
  numList.forEach((num) {
    print("${num} squared is ${num * num}");
  });
}
