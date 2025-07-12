import 'package:dartz/dartz.dart';
import 'package:paintprotest/core/error/failures.dart';
import 'package:paintprotest/features/home/domain/entities/home.dart';

abstract class HomeRepository {
  Future<Either<Failure, Home>> getHome();
}
