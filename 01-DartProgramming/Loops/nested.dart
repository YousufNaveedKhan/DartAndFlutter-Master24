void main() {
    print("Nested Loop");
    for (var f = 1; f <= 5; f++) {
    print("First Loop: ${f}");
    
    for (var s = 6; s <= 12; s++) {
      print("Second Loop: ${s}");
    }
  }
}