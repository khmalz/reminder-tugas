import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';

class HomeController extends GetxController {
  var db = FirebaseFirestore.instance;

  Future<List<Task>> getTasks() async {
    List<Task> tasks = [];

    await db.collection("tasks").get().then((event) {
      for (var doc in event.docs) {
        tasks.add(Task(
          id: doc.id,
          name: doc['name'],
          matkul: doc['matkul'],
          type: doc['type'],
          collection: doc['collection'],
          deadline: DateFormat('dd MMMM yyyy')
              .format((doc['deadline'] as Timestamp).toDate()),
          isDone: doc['is_done'],
        ));
      }
    });

    return tasks;
  }

  // Future<List<Task>> loadTugas() async {
  //   await getTaskFromDB();

  //   String jsonString = await rootBundle.loadString('assets/data/tugas.json');

  //   Map<String, dynamic> jsonResponse = json.decode(jsonString);
  //   List<dynamic> tugasData = jsonResponse['tugas'];

  //   List<Task> tasks = tugasData.map((task) => Task.fromJson(task)).toList();

  //   return tasks;
  // }
}
