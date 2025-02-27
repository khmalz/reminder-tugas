import 'package:talker_flutter/talker_flutter.dart' show AnsiPen, TalkerLog;

class LogGood extends TalkerLog {
  LogGood(String super.message);

  static const logKey = 'good';

  @override
  String get title => 'Good';

  @override
  String? get key => logKey;

  @override
  AnsiPen get pen => AnsiPen()..green();
}
