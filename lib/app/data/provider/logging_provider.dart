import 'package:reminder_tugas/app/data/observer/crashlytics_observer.dart';
import 'package:talker_flutter/talker_flutter.dart' show Talker, TalkerFlutter;

class LoggingProvider {
  static final Talker talker =
      TalkerFlutter.init(observer: CrashlitycsTalkerObserver());

  LoggingProvider._();
}
