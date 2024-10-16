void main() {
  String letter = "J";
  
  switch (letter.toLowerCase()) {
    case 'a':
    case 'e':
    case 'i':
    case 'o':
    case 'u': {
      print("${letter} is a vowel");
      break;
    }
      
    default: {
      print("${letter} is a consonant");
      break;
    }
  }
}
