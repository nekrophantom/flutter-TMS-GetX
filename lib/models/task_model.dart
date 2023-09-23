class Task{
  int? id;
  String? categoryName;
  String? title;
  String? description;
  DateTime? dueDate;
  String? priority;
  String? status;
  String? userName;
  DateTime? createdAt;
  DateTime? updatedAt;

  Task({
    required this.id,
    required this.categoryName,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.status,
    required this.userName,
    required this.createdAt,
    required this.updatedAt
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      categoryName: json['categoryName'],
      title: json['title'],
      description: json['description'],
      dueDate: DateTime.parse(json['due_date']),
      priority: json['priority'],
      status: json['status'],
      userName: json['userName'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

}