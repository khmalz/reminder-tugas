bool validateInput<T>({
  required T? value,
  required Function(String?) setError,
  required String errorMessage,
}) {
  if (value == null || (value is String && value.isEmpty)) {
    setError(errorMessage);
    return false;
  }
  setError(null);
  return true;
}
