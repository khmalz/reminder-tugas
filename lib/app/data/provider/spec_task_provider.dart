import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SpecTaskProvider extends GetConnect {
  final _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getGroupedSpecs() async {
    try {
      Map<String, dynamic> result = {
        'name': [],
        'type': [],
        'collection': [],
      };

      var snapshot = await _firestore.collection('specs').get();

      for (var doc in snapshot.docs) {
        var data = doc.data();

        if (result.containsKey(doc.id)) {
          for (var item in data.values) {
            result[doc.id]!.add(Map<String, dynamic>.from(item));
          }
        }
      }

      return result;
    } catch (e) {
      throw Exception('Error fetching grouped specs: $e');
    }
  }

  Future<String?> getSpecKey(String docId, String dataValue) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('specs').doc(docId).get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        var resultID = data.keys.firstWhere(
          (key) => data[key]['code'] == dataValue,
        );

        return resultID;
      } else {
        return "";
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteSpec(String docId, String dataId) async {
    try {
      await _firestore.collection('specs').doc(docId).update({
        dataId: FieldValue.delete(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addSpec(String docId, Map<String, dynamic> dataNew) async {
    try {
      final docSnapshot = await _firestore.collection('specs').doc(docId).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;
        final keys = data.keys.map((key) => int.tryParse(key) ?? -1).toList();
        final newKey =
            (keys.isEmpty ? 0 : keys.reduce((a, b) => a > b ? a : b) + 1)
                .toString();

        await _firestore.collection('specs').doc(docId).update({
          newKey: dataNew,
        });

        return;
      } else {
        throw Exception("Document $docId does not exist.");
      }
    } catch (e) {
      rethrow;
    }
  }
}
