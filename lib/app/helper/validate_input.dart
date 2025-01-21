bool validateInput<T>({
  required T? value,
  required Function(String?) setError,
  required String errorMessage,
  required bool Function(T?) validator,
}) {
  if (!validator(value)) {
    setError(errorMessage);
    return false;
  } else {
    setError(null);
    return true;
  }
}
