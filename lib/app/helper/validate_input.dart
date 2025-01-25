bool validateInput<T>({
  required T? value,
  required Function(String?) setError,
  required List<MapEntry<bool Function(T?), String>> validatorsWithMessages,
}) {
  for (var entry in validatorsWithMessages) {
    var validator = entry.key;
    var errorMessage = entry.value;
    if (!validator(value)) {
      setError(errorMessage);
      return false;
    }
  }

  setError(null);
  return true;
}
