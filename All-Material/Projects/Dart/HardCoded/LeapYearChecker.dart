void main() {
  int year = 1947;
  if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
    print("");
    print("${year} is a leap year");
  } else {
    print("");
    print("${year} isn't a leap year");
  }
}
