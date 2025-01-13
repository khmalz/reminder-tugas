import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_tugas/app/data/models/task_model.dart';

class DetailTugasController extends GetxController {
  var db = FirebaseFirestore.instance;
  String id = Get.parameters['id'].toString();

  Future<Task?> loadTugasById(String id) async {
    try {
      // Mengambil dokumen tugas berdasarkan ID
      var doc = await db.collection("tasks").doc(id).get();

      // Memeriksa apakah dokumen ada
      if (doc.exists) {
        Task task = Task(
          id: doc.id, // Menyimpan ID dokumen
          name: doc['name'],
          matkul: doc['matkul'],
          type: doc['type'],
          collection: doc['collection'],
          // Mengonversi Timestamp menjadi format tanggal
          deadline: DateFormat('dd MMMM yyyy')
              .format((doc['deadline'] as Timestamp).toDate()),
          isDone: doc['is_done'],
        );

        debugPrint(task.toString());

        return task;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getting task: $e');
      return null;
    }
  }

  // Future<Task?> loadTugasById(String id) async {
  //   String jsonString = await rootBundle.loadString('assets/data/tugas.json');

  //   Map<String, dynamic> jsonResponse = json.decode(jsonString);
  //   List<dynamic> tugasData = jsonResponse['tugas'];

  //   // Mencari tugas dengan ID yang sesuai
  //   var tugasItem = tugasData.firstWhere(
  //     (t) => t['id'].toString() == id,
  //     orElse: () => null,
  //   );

  //   if (tugasItem != null) {
  //     return Task.fromJson(tugasItem);
  //   } else {
  //     return null;
  //   }
  // }
}
