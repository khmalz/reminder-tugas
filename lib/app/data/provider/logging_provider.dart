import 'package:talker_flutter/talker_flutter.dart' show Talker, TalkerFlutter;

class LoggingProvider {
  static final Talker talker = TalkerFlutter.init();

  LoggingProvider._();
}
