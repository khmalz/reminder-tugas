import 'package:hive/hive.dart';

List<Map<String, dynamic>> getSortedList(Box specBox, String key) {
  List<Map<String, dynamic>> list = (specBox.get(key) as List<dynamic>?)
          ?.map((e) => Map<String, dynamic>.from(e))
          .toList() ??
      [];

  list.sort((a, b) => a['title'].compareTo(b['title']));
  return list;
}
