import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TaskProvider extends GetConnect {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getTasks() async {
    List<Map<String, dynamic>> tasksData = [];
    try {
      var snapshot = await _firestore.collection("tasks").get();

      for (var doc in snapshot.docs) {
        tasksData.add({
          'id': doc.id,
          'name': doc['name'],
          'matkul': doc['matkul'],
          'type': doc['type'],
          'collection': doc['collection'],
          'deadline': doc['deadline'],
          'is_done': doc['is_done'],
        });
      }

      return tasksData;
    } catch (e) {
      throw Exception("Error getting tasks: $e");
    }
  }

  Future<void> addTask(Map<String, dynamic> taskData) async {
    try {
      await _firestore.collection("tasks").add(taskData);
    } catch (e) {
      throw Exception("Error adding task: $e");
    }
  }

  Future<void> updateTask(String taskId, Map<String, dynamic> taskData) async {
    try {
      await _firestore.collection("tasks").doc(taskId).update(taskData);
    } catch (e) {
      throw Exception("Error updating task: $e");
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore.collection("tasks").doc(taskId).delete();
    } catch (e) {
      throw Exception("Error deleting task: $e");
    }
  }

  Future<void> updateStatusTask(String taskId, bool status) async {
    try {
      await _firestore
          .collection("tasks")
          .doc(taskId)
          .update({'is_done': !status});
    } catch (e) {
      // Lemparkan exception agar dapat ditangani oleh controller
      throw Exception("Error updating task status: $e");
    }
  }

  Future<Map<String, dynamic>?> loadTaskById(String taskId) async {
    try {
      var doc = await _firestore.collection("tasks").doc(taskId).get();

      if (doc.exists) {
        var taskData = doc.data() as Map<String, dynamic>;
        taskData['id'] = doc.id;
        return taskData;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error loading task by id: $e");
    }
  }
}
