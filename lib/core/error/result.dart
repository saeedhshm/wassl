import 'package:wassl/core/error/failures.dart';

typedef Result<T> = ({Failure? failure, T? data});

Result<T> success<T>(T data) => (failure: null, data: data);
Result<T> failure<T>(Failure f) => (failure: f, data: null);
