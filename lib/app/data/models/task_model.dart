class Task {
  int? id;
  String? name;
  String? matkul;
  String? type;
  String? collection;
  String? deadline;

  Task({
    this.id,
    this.name,
    this.matkul,
    this.type,
    this.collection,
    this.deadline,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'];
    matkul = json['matkul'];
    type = json['type'];
    collection = json['collection'];
    deadline = json['deadline'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['matkul'] = matkul;
    data['type'] = type;
    data['collection'] = collection;
    data['deadline'] = deadline;
    return data;
  }
}
