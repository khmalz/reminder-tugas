import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? matkul;

  @HiveField(3)
  String? type;

  @HiveField(4)
  String? collection;

  @HiveField(5)
  String? deadline;

  @HiveField(6)
  bool isDone = false;

  Task({
    this.id,
    this.name,
    this.matkul,
    this.type,
    this.collection,
    this.deadline,
    this.isDone = false,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'];
    matkul = json['matkul'];
    type = json['type'];
    collection = json['collection'];
    deadline = json['deadline'];
    isDone = json['is_done'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['matkul'] = matkul;
    data['type'] = type;
    data['collection'] = collection;
    data['deadline'] = deadline;
    data['is_done'] = isDone;
    return data;
  }

  @override
  String toString() {
    return 'Task(id: $id, name: $name, matkul: $matkul, type: $type, collection: $collection, deadline: $deadline, isDone: $isDone)';
  }
}
