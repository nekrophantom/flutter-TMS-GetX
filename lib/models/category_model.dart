class CategoryTask{
  int? id;
  String name;

  CategoryTask({
    required this.id,
    required this.name
  });

  factory CategoryTask.fromJson(Map<String, dynamic> json) {
    return CategoryTask(
      id: json['id'],
      name: json['name'],
    );
  }
}