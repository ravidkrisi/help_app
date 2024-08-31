class Result<T> {
  final T? value;
  final Exception? error;
  

  // constructor
  Result({this.value, this.error});

  // getters
  bool get isSuccess => error == null && value != null;
  bool get hasError => error != null && value == null;

  // factory methods
  factory Result.success(T value) {
    return Result(value: value);
  }

  factory Result.failure(Exception error) {
    return Result(error: error);
  }
}
