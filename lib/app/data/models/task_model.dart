class Task {
  String? id;
  String? name;
  String? matkul;
  String? type;
  String? collection;
  String? deadline;
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
