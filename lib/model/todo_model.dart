class ToDoModel {
  String title;
  bool isCompleted;

  ToDoModel({required this.title, required this.isCompleted});

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}
