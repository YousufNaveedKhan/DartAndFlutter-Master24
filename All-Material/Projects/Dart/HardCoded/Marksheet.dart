void main() {
  double eng = 93;
  double urdu = 100;
  double math = 79;

  double total = 300;
  double obt = eng + urdu + math;

  double per = obt / total * 100;

  // Printing marksheet
  print("");
  print("Marksheet: ");
  print("Obtained marks in subject english out of 100 is: ${eng}");
  print("Obtained marks in subject urdu out of 100 is: ${urdu}");
  print("Obtained marks in subject maths out of 100 is: ${math}");

  print("");

  print("Calculated obtained total marks is: ${obt} / ${total}");

  print("Percentage: ${per.toStringAsFixed(2)}");

  // Calculating Grades
  if (per >= 80 && per <= 100) {
    print("A+");
  } else if (per >= 70 && per <= 80) {
    print("A");
  } else if (per >= 60 && per <= 70) {
    print("B");
  } else if (per >= 50 && per <= 60) {
    print("C");
  } else if (per >= 40 && per <= 50) {
    print("D");
  } else {
    print("FAIL");
  }
}
