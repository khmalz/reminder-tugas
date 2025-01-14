import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';

class HomeController extends GetxController {
  Rx<List<Map<String, int>>> statList = Rx<List<Map<String, int>>>([
    {"late": 0},
    {"pending": 0},
    {"done": 0},
  ]);

  var db = FirebaseFirestore.instance;

  Future<List<Task>> getTasks() async {
    List<Task> tasks = [];
    int late = 0, pending = 0, done = 0;

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

        DateTime taskDeadline = (doc['deadline'] as Timestamp).toDate();
        if (taskDeadline.isBefore(DateTime.now())) {
          late++;
        }

        if (doc['is_done'] == false) {
          pending++;
        } else {
          done++;
        }
      }
    });

    statList.value = [
      {"late": late},
      {"pending": pending},
      {"done": done},
    ];

    return tasks;
  }
}
