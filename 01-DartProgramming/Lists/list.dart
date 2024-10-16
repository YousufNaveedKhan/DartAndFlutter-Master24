void main() {
  var studentsList = ["John", "Mark", "Bob", "Paul", "Olivia"];
  print("Students: ${studentsList}");
  
  studentsList.add("David");
  print("Students: ${studentsList}");
  
  var names = ["Kabeer", "Zahid", "Hamza"];
  
  studentsList.addAll(names);
  print("Students: ${studentsList}");
  
  studentsList.insert(3, "Ebaad");
  print("Students: ${studentsList}");
  
  var newNames = ["Jawwad", "Fin", "George"];
  
  studentsList.insertAll(0, newNames);
  print("Students: ${studentsList}");
  
  newNames[0] = "Cody";
  print("Students: ${newNames}");
  
  studentsList.add("Eric");
  
  studentsList.replaceRange(1, 4, ["Ali", "Talha", "Owais"]);
  
//   for (var studentList in studentsList) {
//     print("Student Name: ${studentList}");
//   }
  

  print("Students: ${studentsList}");
  studentsList.remove("Kabeer");
  print("Students: ${studentsList}");
  
  
  studentsList.removeAt(4);
  print("Students: ${studentsList}");
  
  studentsList.removeLast();
  print("Students: ${studentsList}");
  
  studentsList.removeRange(2,5);
  print("Students: ${studentsList}");
  

  print("Length: ${studentsList.length}");
  print("Reverse: ${studentsList.reversed}");
  print("First: ${studentsList.first}");
  print("Last: ${studentsList.last}");
  print("Is Empty: ${studentsList.isEmpty}");
  print("Is Not Empty: ${studentsList.isNotEmpty}");
  
}