import 'package:firebase_crashlytics/firebase_crashlytics.dart'
    show FirebaseCrashlytics;
import 'package:talker_flutter/talker_flutter.dart'
    show TalkerData, TalkerError, TalkerException, TalkerObserver;

class CrashlitycsTalkerObserver extends TalkerObserver {
  @override
  void onError(TalkerError err) {
    super.onError(err);

    FirebaseCrashlytics.instance.recordError(
      err.error,
      err.stackTrace,
      reason: err.message,
    );
  }

  @override
  void onException(TalkerException err) {
    super.onException(err);

    FirebaseCrashlytics.instance.recordError(
      err.exception,
      err.stackTrace,
      reason: err.message,
    );
  }

  @override
  void onLog(TalkerData log) {
    super.onLog(log);

    FirebaseCrashlytics.instance.log(log.generateTextMessage());
  }
}
