void main() {
  // Signup
  String name = "Yousuf Naveed Khan";
  String email = "yousufnaveedkhan@gmail.com";
  String pass = "Yousufnaveedkhan23";

  // Printing Signup Info
  print("Name: ${name}");
  print("Email: ${email}");
  print("Password: ${pass}");
  print("");

  String loginEmail = "yousufnaveedkhan@gmail.com";
  String loginPass = "Yousufnaveedkhan23";

  if (email == loginEmail && pass == loginPass) {
    print("Welcome to Dart World, ${name}!");
  } else {
    print("Incorrect email or password!");
  }
}
