import 'package:dartz/dartz.dart';

import '../../error/failures.dart';

abstract class UseCaseBase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}
